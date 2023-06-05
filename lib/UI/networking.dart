import 'dart:convert';
import 'package:http/http.dart';

class NetworkManager {
  NetworkManager(this.url);

  final String url;
  var decodedData;

  Future<List> collectData() async {
    Response response = await get(
        Uri.parse(url)); // worked after adding 'https://' in front of the URL

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      print(decodedData);
      // print(decodedData['list'][0]['main']['aqi']);

      return decodedData;
    } else {
      return [null];
    }
  }
}
