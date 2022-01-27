import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart';
import 'package:patterns_provider/pages/update_page.dart';
import 'package:patterns_provider/services/http_service.dart';
import 'package:patterns_provider/viewmodel/home_view_model.dart';
import 'package:patterns_provider/views/item_of_post.dart';
import 'package:provider/provider.dart';
import '../model/post_model.dart';
import 'create_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
 static final String id = "home_page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 HomeViewModel viewModel = HomeViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.apiPostList();
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => viewModel,
          child: Consumer<HomeViewModel>(
            builder: (ctx, model, index) => Stack(
              children: [
                Container(
                  child: ListView.builder(
                    itemCount: viewModel.items.length,
                    itemBuilder: (ctx, index) {
                      return itemOfPost(ctx, viewModel, viewModel.items[index]);
                    },
                  ),
                ),
                viewModel.isLoading ?
                Center(
                  child: CircularProgressIndicator(),
                ) : SizedBox.shrink()
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
           onPressed: (){
             viewModel.apiCreatePost(context, );
           },
          child: Icon(Icons.add),
        ),
      );
    }
  }

