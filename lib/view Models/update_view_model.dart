import 'package:flutter/material.dart';
import 'package:patterns_scoped/models/post_model.dart';
import 'package:patterns_scoped/services/functions/create_delete_add.dart';
import 'package:scoped_model/scoped_model.dart';

class Update_view_model extends Model {
  bool isloading = false;
  var control1 = TextEditingController();
  var control2 = TextEditingController();
  Post post;

  Update_view_model({required this.post}) {
    control1.text = this.post.title;
    control2.text = this.post.body;
  }

  Update(BuildContext context) async {
    var text1 = control1.text.trim();
    var text2 = control2.text.trim();
    if (text1.isNotEmpty && text2.isNotEmpty) {
      isloading = true;
      notifyListeners();
      post.title = text1;
      post.body = text2;
      await Create_delete_add_function.Update(post);
      isloading = false;
      notifyListeners();
      Navigator.pop(context, "new_post");
    } else {
      var message = (text1.isEmpty && text2.isEmpty)
          ? "Title and Body"
          : text1.isEmpty
              ? "Title"
              : "Body";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message + " are empty",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: .5),
          ),
          action: SnackBarAction(
            label: 'Exit',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    }
  }
}
