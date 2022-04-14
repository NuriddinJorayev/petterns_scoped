import 'package:flutter/material.dart';
import 'package:patterns_scoped/models/post_model.dart';
import 'package:patterns_scoped/pages/create_post_page.dart';
import 'package:patterns_scoped/view%20Models/home_view_models.dart';
import 'package:patterns_scoped/views/item_of_home.dart';
import 'package:scoped_model/scoped_model.dart';

class Home extends StatefulWidget {
  static final String id = "home_page";
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var base_model = Home_view_models();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Scoped"),
      ),
      body: ScopedModel<Home_view_models>(
        model: base_model,
        child: ScopedModelDescendant<Home_view_models>(
          builder: (context, child, model) => Stack(
            children: [
              Container(
                height: h,
                width: w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://i.pinimg.com/originals/4b/f2/b3/4bf2b361a67b3030b185fd7447b279b5.jpg"),
                        fit: BoxFit.fill)),
                child: FutureBuilder<List<Post>>(
                  future: model.future,
                  builder: (BuildContext context, snp) {
                    if (snp.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snp.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return items_builder(context, snp.data![index], () {
                            model.Delete(snp.data![index]);
                          });
                        },
                      );
                    } else if (snp.connectionState == ConnectionState.waiting) {
                      return Container(
                        height: h,
                        width: w,
                        color: Colors.black.withOpacity(.4),
                        child: Container(
                          height: 60,
                          width: 60,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              base_model.isloading
                  ? Container(
                      height: h,
                      width: w,
                      color: Colors.black.withOpacity(.4),
                      child: Container(
                        height: 60,
                        width: 60,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Create_post.id).then((value) {
            if (value != null) {
              base_model.initialize_future();
            }
            FocusScope.of(context).requestFocus(FocusNode());
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
