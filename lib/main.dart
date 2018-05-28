import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> getCurrencies() async {
  String apiUrl = 'https://api.coinmarketcap.com/v1/ticker/?limit=50';
  http.Response response = await http.get(apiUrl);
  return JSON.decode(response.body);
}

void main() async {
  print('Hello World');

  List currencies = await getCurrencies();
  print(currencies);

  // Roda o MaterialApp widget
  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CryptoListWidget(currencies)
    )
  );
}

class CryptoListWidget extends StatelessWidget {

  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];
  final List _currencies;

  CryptoListWidget(this._currencies);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _buildBody(),
      backgroundColor: Colors.blue,
    );
  }

  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.fromLTRB(8.0, 56.0, 8.0, 8.0),
      child: Column(
        children: <Widget>[
           _getAppTitleWidget(),
          _getAppViewWidget()
        ],
      ),
    );
  }

  Widget _getAppTitleWidget() {
    return Text(
      'Cryptocurrencies',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24.0
      ),
    );
  }

  Widget _getAppViewWidget() {
    return Flexible(
      child: ListView.builder(
        itemCount: _currencies.length,
        itemBuilder: (context, index) {
          final Map currency = _currencies[index];
          final MaterialColor color = _colors[index % _colors.length];
          return _getListItemWidget(currency, color);
        },
      ),
    );
  }

  Widget _getListItemWidget(Map currency, MaterialColor color) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: Card(
        child: _getListTile(currency, color),
      ),
    );
  }

  CircleAvatar _getLeadingWidget(String currencyName, MaterialColor color) {
    return CircleAvatar(
      backgroundColor: color,
      child: Text(currencyName[0]),
    );
  }

  Text _getTitleWidget(String currencyName) {
    return Text(
      currencyName,
      style: TextStyle(
        fontWeight: FontWeight.bold
      ),
    );
  }

  Text _getSubtitleWidget(String priceUsd, String percentChange1h) {
    return Text('\$$priceUsd\n1 hour: $percentChange1h%');
  }

  ListTile _getListTile(Map currency, MaterialColor color) {
    return ListTile(
      leading: _getLeadingWidget(currency['name'], color),
      title: _getTitleWidget(currency['name']),
      subtitle: _getSubtitleWidget(
          currency['price_usd'],
          currency['percent_change_1h']
      ),
      isThreeLine: true,
    );
  }

}

























