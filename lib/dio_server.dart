import 'package:dio/dio.dart';

const _API_PREFIX = 'http://4f5686f5c147.ngrok.io/prediction';

class Server {

  Future<String> postReq(String query) async {
    Response response;
    Dio dio = new Dio();
    Map<String, dynamic> data ={"text":query};
//    data.putIfAbsent("userId", () => 189);
    response = await dio.post(_API_PREFIX, data: data);

    return response.data.toString();
  }
}

Server server  = Server();