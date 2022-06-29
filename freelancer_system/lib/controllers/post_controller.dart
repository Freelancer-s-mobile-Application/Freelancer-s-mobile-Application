import 'package:freelancer_system/models/Post.dart';
import 'package:freelancer_system/services/PostService.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  static PostController instance = Get.find();

  Rx<List<Post>> postList = Rx<List<Post>>([]);

  List<Post> get posts => postList.value;

  @override
  void onInit() {
    postList.bindStream(PostService().postStream());
    super.onInit();
  }
}
