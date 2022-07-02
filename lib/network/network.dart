import 'package:http/http.dart' as http;

import '../model/products_model.dart';

class HttpApi {
  Future<dynamic> getProducts() async {
    try {
      var response = await http
          .get(Uri.parse('https://api.jikan.moe/v3/search/anime?q=naruto'));

      if (response.statusCode == 200) {
        print(response.body);
        final data = productModelFromJson(response.body);
        return data.results;
      } else {
        print(response.reasonPhrase);
        return "something went wrong";
      }
    } catch (exception, stack) {
      return "something went wrong";
    }
  }
}
