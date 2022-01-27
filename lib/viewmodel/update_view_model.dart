import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:patterns_provider/model/post_model.dart';
import 'package:patterns_provider/services/http_service.dart';

class UpdateViewModel extends ChangeNotifier{
  var titleController = TextEditingController();
  var bodyController = TextEditingController();
  bool isLoading = false;
  Post lastPost;

  getLastPost(Post post)async{
    lastPost = post ;
    titleController.text = lastPost.title;
    bodyController.text = lastPost.body;
    notifyListeners();
  }

  apiCreatePost(BuildContext context)async{
    isLoading = true;
    notifyListeners();
    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();
    Post post = Post(title: title, body: body, userId: lastPost.userId, id: lastPost.id);

    var response = await Network.PUT(Network.API_UPDATE + lastPost.userId.toString(), Network.paramsUpdate(post));
    print(response);

    isLoading = false;
    if(response!= null){
      Navigator.pop( context, response);
    }else{
      print("Error mannnn");
    }
    notifyListeners();
  }
}
