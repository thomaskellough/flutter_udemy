import 'dart:convert';

import 'package:http/http.dart' as http;

const coinAPIurl = 'https://rest.coinapi.io/v1/exchangerate/{0}/{1}';
const coinAPIKey = '168D3D06-40D1-4F9A-A12F-DE7E3722A7B0';

class NetworkingService {
  
  Future<dynamic> getConversionRate({String coin, String currency}) async {
    Uri url = Uri.parse(coinAPIurl.replaceAll('{0}', coin).replaceAll('{1}', currency));
    print('Getting response from....$url');
    http.Response response = await http.get(url, headers: {'X-CoinAPI-Key': coinAPIKey});
    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      return null;
    }
  }
}