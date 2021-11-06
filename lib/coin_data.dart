import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth/secrets.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map lastPriceMap = {};
    for (String coin in cryptoList) {
      Uri requestURL =
          Uri.parse('$coinAPIURL/$coin/$selectedCurrency?apiKey=$apiKey');
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        lastPriceMap[coin] = decodedData['rate'];
      } else {
        print(response.statusCode);
        throw 'Problem with the get request for $coin';
      }
    }
    return lastPriceMap;
  }
}
