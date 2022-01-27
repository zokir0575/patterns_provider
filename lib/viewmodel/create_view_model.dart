import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:patterns_provider/model/post_model.dart';
import 'package:patterns_provider/services/http_service.dart';

class CreateViewModel extends ChangeNotifier{
  bool isLoading = false;
  var titleController = TextEditingController();
  var bodyController = TextEditingController();

  Future apiCreatePost(BuildContext context)async{
    isLoading = true;
    notifyListeners();
    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();
    Post post = Post(title: title, body: body, userId: 1);

    var response = await Network.POST(Network.API_CREATE, Network.paramsCreate(post));
    print(response);
    if(response != null){
      Navigator.pop(context, response);
    }else{
      print("IT IS ERROR MAN");
    }
    notifyListeners();
  }
}