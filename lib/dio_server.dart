import 'package:dio/dio.dart';

const _API_PREFIX = 'http://3e4337d6.ngrok.io/prediction';

class Server {

  Future<String> postReq(String query) async {
    Response response;
    Dio dio = new Dio();
    Map<String, dynamic> data ={"sen_1":query, "sen_2": "how are you"};
//    data.putIfAbsent("userId", () => 189);
    response = await dio.post(_API_PREFIX, data: data);
    return response.data.toString();
  }
}

Server server  = Server();