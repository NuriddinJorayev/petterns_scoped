import 'package:flutter/foundation.dart';
import 'package:patterns_scoped/models/post_model.dart';
import 'package:patterns_scoped/services/functions/create_delete_add.dart';
import 'package:patterns_scoped/services/http_server.dart';
import 'package:scoped_model/scoped_model.dart';

class Home_view_models extends Model {
  Future<List<Post>>? future;
  bool isloading = false;

  Home_view_models() {
    initialize_future();
  }

  initialize_future() {
    isloading = true;
    notifyListeners();
    future = Rest_APi.GET_parsed_list(Rest_APi.API_GET);
    isloading = false;
    notifyListeners();
  }

  Delete(Post p) async {
    isloading = true;
    notifyListeners();
    await Create_delete_add_function.Delete(p).then((value) async {
      if (value.isNotEmpty) {
        initialize_future();
      }
    });
  }
}
