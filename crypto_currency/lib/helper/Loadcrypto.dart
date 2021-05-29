import 'package:crypto_currency/models/Crypto.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class LoadCrypto{


  List<Crypto> crypto = [];

  Future<void> getCrypto() async{
    String cryptoUrl = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";
    final response = await http.get(
        Uri.parse(cryptoUrl),
        headers: {
          'X-CMC_PRO_API_KEY': 'fad815e8-f0fc-4bff-934e-78ed638e4088',
          "Accept": "application/json",
        });
    var jsonData = jsonDecode(response.body);

    jsonData["id"].forEach((element){

      Crypto cryptoo = Crypto(
          name:element['name'],
          symbol: element['symbol'],
          slug: element['slug'],
          percent_change_1h: element['percent_change_1h']


      );

      crypto.add(cryptoo);
    });

  }
}

