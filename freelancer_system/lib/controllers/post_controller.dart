import '../models/Post.dart';
import '../services/PostService.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  static PostController instance = Get.find();

  Rx<List<Post>> postList = Rx<List<Post>>([]);
  Rx<Post> post = Rx<Post>(Post());
  Rx<String> postContent = Rx<String>('');
  RxBool isSearch = RxBool(false);

  Rx<List<Post>> myPosts = Rx<List<Post>>([]);
  RxBool isMySearch = RxBool(false);

  String get postContentValue => postContent.value;
  Post get postValue => post.value;
  List<Post> get posts => postList.value;

  Rx<List<Post>> searchList = Rx<List<Post>>([]);
  Rx<String> searchKey = Rx<String>('');
  Rx<String> mySearchKey = Rx<String>('');

  @override
  void onInit() {
    postList.bindStream(PostService().postStream());
    myPosts.bindStream(PostService().myPostsStream());
    super.onInit();
  }

  List<Post> search(String search) {
    return searchList.value = posts
        .where((post) =>
            post.title!.toLowerCase().contains(searchKey.value.toLowerCase()))
        .toList();
  }

  List<Post> searchMyList(String search) {
    return searchList.value = myPosts.value
        .where((post) =>
            post.title!.toLowerCase().contains(mySearchKey.value.toLowerCase()))
        .toList();
  }
}
