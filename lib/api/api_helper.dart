import 'dart:js_interop_unsafe';
import '';

class ApiHelper {
  Future<dynamic> getApi(
      {required String url, Map<String, String>? mHeader}) async {
    var res = await http.get(Uri.parse(url),
        headers: mHeader ??
            {
              "Authorization":
                  "aMDZJHEwVRvmgLkoJWyMmRhiJNEshBcghHz4Txs7SQdOGbZfb5vM5XWZ"
            });
  }
}
