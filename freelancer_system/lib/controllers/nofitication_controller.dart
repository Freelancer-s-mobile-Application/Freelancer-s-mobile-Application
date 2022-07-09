import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freelancer_system/services/UserService.dart';
import '../constants/controller.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

class NofiticationController extends GetxController {
  static NofiticationController instance = Get.find();
  late FirebaseMessaging messaging;
  late NotificationSettings settings;
  @override
  void onInit() async {
    messaging = FirebaseMessaging.instance;
    settings = await getPermission();
    list();
    super.onInit();
  }

  void list() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground!');
      // print('Message data: ${message.data}');

      if (message.notification != null) {
        // print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<NotificationSettings> getPermission() async {
    return messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}

class LocalNofiController extends GetxController {
  static LocalNofiController instance = Get.find();

  static final LocalNofiController _notificationService =
      LocalNofiController._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory LocalNofiController() {
    return _notificationService;
  }

  LocalNofiController._internal();

  @override
  void onInit() {
    super.onInit();
    initNofitication();
  }

  Future initNofitication() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_launcher');

    AndroidNotificationChannelGroup androidNotificationChannelGroup =
        const AndroidNotificationChannelGroup('message', 'Message Channel');

    IOSInitializationSettings initializationSettingsIOS =
        const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannelGroup(androidNotificationChannelGroup);
  }

  Future showNofitication(
      int id, String title, String body, String type) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          type,
          type,
          importance: Importance.max,
          priority: Priority.max,
          ticker: 'ticker',
          icon: '@drawable/ic_launcher',
          setAsGroupSummary: true,
        ),
        iOS: const IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  Future groupNotifications() async {
    List<ActiveNotification>? activeNotifications =
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.getActiveNotifications();
    if (activeNotifications != null && activeNotifications.length > 1) {
      List<String> lines = activeNotifications.map((e) {
        print('channel: ${e.channelId}');
        print('tag ${e.tag}');
        print('id ${e.id}');
        return '${e.title.toString()}: ${e.body.toString()}';
      }).toList();
      InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
        lines,
        // contentTitle: "${activeNotifications.length - 1} Updates CONTENT",
        // summaryText: "${activeNotifications.length - 1} Updates SUMMARY",
      );
      flutterLocalNotificationsPlugin.cancelAll();
      AndroidNotificationDetails groupNotificationDetails =
          AndroidNotificationDetails(
        'main-channel',
        'Main Channel',
        styleInformation: inboxStyleInformation,
        setAsGroupSummary: true,
        groupKey: 'message',
        // onlyAlertOnce: true,
      );
      NotificationDetails groupNotificationDetailsPlatformSpefics =
          NotificationDetails(android: groupNotificationDetails);
      await flutterLocalNotificationsPlugin.show(
          0, '', '', groupNotificationDetailsPlatformSpefics);
    }
  }

  void listenToRoom() {
    String uMail = authController.firebaseuser.value!.email.toString();
    FirebaseFirestore.instance
        .collection('ChatRooms')
        .where('userIds', arrayContains: uMail)
        .snapshots()
        .listen((event) async {
      print(event.docChanges.length);
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            var data = change.doc.data()!;
            if (!await isRoomMeAdmin(data)) {
              localNofiController.showNofitication(
                randomId(),
                'You were added to a chat room',
                '${getRoomAdmin(data)} started a chat with you',
                'msg',
              );
            }
            break;
          case DocumentChangeType.modified:
            break;
          case DocumentChangeType.removed:
            break;
        }
      }
    });
  }

  void listenForTextMsg(String roomId) {
    FirebaseFirestore.instance
        .collection('ChatRooms')
        .doc(roomId)
        .collection('messages')
        .snapshots()
        .listen((event) async {
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            var data = change.doc.data()!;
            if (!isMeSender(data)) {
              final name = await UserService().findByMail(data['authorId']);
              String text = data['text'];
              if (data['type'] == 'file') {
                text = 'send a file';
              } else if (data['type'] == 'image') {
                text = 'send an image';
              } else if (GetUtils.isURL(data['text'])) {
                text = 'send a link';
              }
              localNofiController.showNofitication(
                randomId(),
                '${name.displayname} sent a message',
                '${name.displayname} : $text',
                'msg',
              );
            }
            break;
          case DocumentChangeType.modified:
            break;
          case DocumentChangeType.removed:
            break;
        }
      }
    });
  }

  int randomId() {
    return Random().nextInt(100);
  }

  String getRoomAdmin(Map<String, dynamic> data) {
    List<String> userIds = data['userIds'];
    String name = '';
    var userRoles = data['userRoles'];
    for (var e in userIds) {
      if (userRoles[e] == 'admin') {
        name = e;
      }
    }
    return name;
  }

  bool isMeSender(Map<String, dynamic> data) {
    String uMail = authController.firebaseuser.value!.email.toString();
    return data['authorId'] == uMail;
  }

  Future<bool> isRoomMeAdmin(Map<String, dynamic> data) async {
    String uMail = authController.firebaseuser.value!.email.toString();
    return Future.delayed(const Duration(seconds: 2), () {
      if ((data['userRoles'][uMail]) == 'admin') {
        return true;
      }
      return false;
    });
  }
}
