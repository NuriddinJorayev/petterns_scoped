import 'package:flutter/material.dart';
import 'package:patterns_scoped/view%20Models/create_view_model.dart';
import 'package:patterns_scoped/widgets/text_field.dart';
import 'package:scoped_model/scoped_model.dart';

class Create_post extends StatefulWidget {
  static final String id = "create_post";
  Create_post({
    Key? key,
  }) : super(key: key);

  @override
  State<Create_post> createState() => _Create_postState();
}

class _Create_postState extends State<Create_post> {
  var base_model = Create_view_model();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Post"),
      ),
      body: ScopedModel<Create_view_model>(
        model: base_model,
        child: ScopedModelDescendant<Create_view_model>(
          builder: (context, child, model) => SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: h,
                  width: w,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text_Field.Create_textFiled("Title", model.control1, 3),
                      Text_Field.Create_textFiled("Body", model.control2, 6),
                    ],
                  ),
                ),
                model.isloading
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          base_model.Create(context);
        },
        child: Icon(Icons.send),
      ),
    );
  }
}
