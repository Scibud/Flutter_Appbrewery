import 'dart:convert';
import 'package:http/http.dart' as http;

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

Map<String, String> cryptoLoop = {};
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '3D394078-EFDD-4DC3-9070-17412F6291DC';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    //TODO 4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    for (String crypto in cryptoList) {
      String requestURL =
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        String lastPrice = decodedData['rate'].toStringAsFixed(0);
        cryptoLoop[crypto] = lastPrice;
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    //TODO 5: Return a Map of the results instead of a single value.
    print(cryptoLoop);
    return cryptoLoop;
  }
}
