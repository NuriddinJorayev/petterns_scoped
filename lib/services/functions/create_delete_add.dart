import 'package:patterns_scoped/models/post_model.dart';
import 'package:patterns_scoped/services/http_server.dart';

class Create_delete_add_function {
  static Future<String> Delete(Post p) async {
    return await Rest_APi.DEL(
        Rest_APi.API_DELETE + p.id.toString(), Rest_APi.paramsEmpty());
  }

  static Future<String> Update(Post p) async {
    return await Rest_APi.PUT(
        Rest_APi.API_UPDATE + p.id.toString(), Rest_APi.paramsUpdate(p));
  }

  static Future<String> Create(Post p) async {
    return await Rest_APi.POST(Rest_APi.API_CREATE, Rest_APi.paramsCreate(p));
  }
}
