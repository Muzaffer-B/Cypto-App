import 'dart:convert';
import 'dart:io';

import 'package:crypto_currency/helper/Loadcrypto.dart';
import 'package:crypto_currency/models/Crypto.dart';
import 'package:crypto_currency/models/walletcrypto.dart';
import 'package:crypto_currency/scrrens/demo_scene.dart';
import 'package:crypto_currency/scrrens/news.dart';
import 'package:crypto_currency/scrrens/settings.dart';
import 'package:crypto_font_icons/crypto_font_icon_data.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'currencies_screen.dart';
import 'notification.dart';

class screen1 extends StatefulWidget {

  final walletlist;
  final walletprice;
  bool is_true;
  screen1({@required this.walletlist,this.is_true,@required this.walletprice});

  @override
  _screen1State createState() => _screen1State(walletlist,is_true,walletprice);
}

bool themeSwitch = false;

class _screen1State extends State<screen1> {

  final walletlist;
  final walletprice;
  bool is_true;
  _screen1State(this.walletlist,this.is_true,this.walletprice);


  List<WalletCrypto> coinlist =  List();

  var list;
  var refreshkey = GlobalKey<RefreshIndicatorState>();
  final PageController _pageController = PageController();

  //List<Crypto> cryptos = new List<Crypto>();
  // List currencies;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];
  double _curentPosition = 0;
  int coinCounter;
  List<CoinMarket> coins = List();
  List<CoinMarket> filteredCoins = List();


  void initState() {
    super.initState();
    Services.getCoins().then((coinsList) {
      coins = coinsList;
      filteredCoins = coins;
    });

    coinlist = walletlist;
    is_true = true;

    _pageController.addListener(() {
      _curentPosition = _pageController.page;
      setState(() {});
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      filteredCoins = coins;
    });
    return null;
  }

  CryptoFontIconData cryptoFontIconData;
  CryptoFontIcons  _icons;
  /*
  getCurrencies() async{
    LoadCrypto Crypto = LoadCrypto();
    await Crypto.getCrypto();
    cryptos = Crypto.crypto;


  }
*/
/*
  int count =1;

  void changecolor() {
    count++;
   if(count % 2 == 1){
     setState(() {
       Color color2 = Color(0XFF313347);
       Color color3 = Color(0XFF5F627D);
     });

   } if(count %2 == 0){

     setState(() {
       color2 = color;
       color3 = color;
     });

   }
   print(count);

  }
*/
/*
  create_dialog(BuildContext context){
    return showDialog(context: context, builder: (context){

      return Dialog(
        child: Column(
          children: [
            Container(
              child: Text('Demo Yeterli bilgi sahibi olmayan kulanıcıların\n borsaya giriş yapmadan önce deneyim\n kazanmaları için yapılmış uygulamadır. '),
            ),
          ],
        ),
      );
    });
  }
*/
  int i = 0;
  int m = 0;


  int _currentindex = 0;

  void _increment_counter() {
    setState(() {
      m++;
    });
  }

  bool themeSwitch = false;

  dynamic themeColors() {
    if (themeSwitch) {
      return Colors.white;
    } else {
      return Color(0XFF5F627D);
    }
  }


  @override
  Widget build(BuildContext context) {
    _increment_counter();
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12),
                height: 130,
                width: double.infinity,

                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 3,
                  itemBuilder: (context, index) => Column(
                  children: [
                    DotsIndicator(
                        dotsCount: 3,
                      position: _curentPosition,
                      decorator: DotsDecorator(
                        activeColor: Colors.white,size: Size(4,4),
                      )
                    ),

                    TextButton(
                      child: Text('Try Demo',style: TextStyle(fontSize: 25,color: Colors.black87,fontStyle: FontStyle.italic),),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Demo_scene(walletlist: coinlist,is_true: is_true,walletprice: walletprice)));
                      }

                    ),
                  ],
                ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(0, 10),
                      color: Colors.black54,
                      spreadRadius: -5,
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0XFF08AEEA), Color(0XFF2AF598)],
                  ),
                ),
              ),
              /*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Coins',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),


                ],
              ),
              */

              Padding(
                padding: EdgeInsets.only(
                  bottom: 10,
                ),
              ),
              Container(
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.only(left: 200),
                child: TextField(

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,

                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontSize: 18,

                    ),
                  ),
                  onChanged: (string) {
                    setState(() {
                      filteredCoins = coins
                          .where((u) => (u.fullName
                          .toLowerCase()
                          .contains(string.toLowerCase()))
                          ||(u.name
                              .toLowerCase()
                              .contains(string.toLowerCase())))
                          .toList();
                    });
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: Services.getCoins(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.black),
                        ),
                      );
                    }
                    coins = snapshot.data;
                    return RefreshIndicator(
                      onRefresh: _refresh,
                      color:themeSwitch ? Color(0XFF5F627D) : Colors.white,
                      backgroundColor: Colors.pink,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child:ListView.builder(
                              padding: EdgeInsets.all(7),
                              itemCount: filteredCoins.length,
                              itemBuilder: (BuildContext context, int index){
                                coinCounter=index;
                                String X = filteredCoins[index].name;
                                return Card(

                                  child: ListTile(
                                    focusColor: themeSwitch ? Color(0XFF5F627D) : Colors.white,
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CurrenciesScreen(is_true: themeSwitch,coinDetail: filteredCoins[index])));
                                    },
                                    leading:Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${coinCounter+1}',
                                        ),

                                        Icon(CryptoFontIcons.BTC),

                                      ],
                                    ),
                                    title:Text(
                                      filteredCoins[index].fullName,
                                      style: TextStyle(fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    subtitle:Text(
                                      filteredCoins[index].name,
                                      style: TextStyle(fontSize: 14,
                                          color: Colors.grey),
                                    ),
                                    trailing:Text(
                                      '\$${filteredCoins[index].price.toStringAsFixed(4)}',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
              /*RefreshIndicator(
                    key: refreshkey,
                    child: FutureBuilder<List<CoinMarket>>(
                      future: list,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<CoinMarket> coins = snapshot.data;

                          return ListView(
                            children: coins.map((coin) =>
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, bottom: 8.0),
                                              child: Image.network(
                                                  'hhttps://s2.coinmarketcap.com/static/img/coins/16x16/${coin
                                                      .symbol
                                                      .toLowerCase()}.png'),
                                              width: 56,
                                              height: 56,
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.all(
                                                  4.0),
                                              child: Text(
                                                  '${coin.symbol} | ${coin
                                                      .name}'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )).toList(),
                          );
                        } else if (snapshot.hasError) {
                          Text('Error while Loading Coin list: ${snapshot
                              .error}');
                        }
                        return new CircularProgressIndicator();
                      },
                    ),
                    onRefresh: refreshListCoin,
                  )*/

            ],
          ));



        // This trailing comma makes auto-formatting nicer for build methods.


  }


}

ListTile _getListItemUi(Map currency,MaterialColor color){
  return  new ListTile(
    leading: new CircleAvatar(backgroundColor: color,
      child: new Text(currency['name'] [0]),
    ),
    title: new Text(currency['name'],style: new TextStyle(fontWeight: FontWeight.bold),),
    subtitle: _getSubtitleText(currency['price_usd'],currency['percent_change_1h']),
    isThreeLine: true,
  );
}

Widget _getSubtitleText(String priceUSD, String percentageChange){
  TextSpan priceTextWidget = new TextSpan(text: "\$$priceUSD\n",
      style: new TextStyle(color: Colors.black));
  String percentageChangeText = "1 hour: $percentageChange%";
  TextSpan percentageChangeTextWidget;

  if(double.parse(percentageChange) >0){

    percentageChangeTextWidget = new TextSpan(text: percentageChangeText,
        style: new TextStyle(color: Colors.green));
  }else{
    percentageChangeTextWidget = new TextSpan(text: percentageChangeText,
        style: new TextStyle(color: Colors.red));
  }

  return new RichText(
    text: new TextSpan(
        children: [priceTextWidget,percentageChangeTextWidget]
    ),
  );
}
/*
  Future<Null> refreshListCoin() async {
    refreshkey.currentState?.show(atTop: false);

    setState(() async{
      list = await fetchListCoin();
    });

    return null;
  }
}

*/

/*
class ListCrypto extends StatelessWidget {
  final String name,symbol,slug,percent_change_1h;
  ListCrypto({@required this.name,@required this.symbol,@required this.slug, @required this.percent_change_1h});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Color(0xFFF5B300), shape: BoxShape.circle),
            child: Icon(CryptoFontIcons.BTC),
          ),
          Text('helloo'),
        ],


      ),
    );
  }
}
*/
class Services{

  static const int coinNum=100;


  static Future<List<CoinMarket>> getCoins() async{

    String url='https://min-api.cryptocompare.com/data/top/totalvolfull?limit=10&tsym=USD';
    List<CoinMarket> coins=[];
    try{
      final response=await http.get(Uri.parse(url));
      if (response.statusCode==200){
        Map<String,dynamic> data=json.decode(response.body);
        List<dynamic> coinList=data['Data'];
        coinList.forEach((json)=>coins.add(CoinMarket.fromJson(json)));
      }
      return coins;

    } catch(e){
      throw Exception(e.toString());
    }
  }

}
/*
Future<List<CoinMarket>> fetchListCoin() async{
  final response = await http.get(
      Uri.parse("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"),
      headers: {
        'X-CMC_PRO_API_KEY': 'fad815e8-f0fc-4bff-934e-78ed638e4088',
        "Accept": "application/json",
      });

  if(response.statusCode ==200){
    List coins = json.decode(response.body);
    return coins.map((coin) => new CoinMarket.fromJson(coin)).toList();
  }else{
    throw Exception('Failed to load Coin List');
  }
}
*/
class CoinMarket{
  final String name;
  final String fullName;
  final double price;
  final double change;
  final String symbol;
  final double maxsupply;
  final double openday;
  final double highday;
  final double lowday;
  final double changepct;
  final String marketcap;
  final String totalvolume24h;

  const CoinMarket({
    this.name,
    this.fullName,
    this.price,
    this.change,
    this.symbol,
    this.maxsupply,
    this.openday,
    this.highday,
    this.lowday,
    this.changepct,
    this.marketcap,
    this.totalvolume24h,

  });


  factory CoinMarket.fromJson(Map<String, dynamic> json) {
    return CoinMarket(
      name: json['CoinInfo']['Name'] as String,
      fullName: json['CoinInfo']['FullName'] as String,
      symbol: json['CoinInfo']['ImageUrl']as String,
      price: (json['RAW']['USD']['PRICE'] as num).toDouble(),
      change: (json['RAW']['USD']['CHANGE24HOUR'] as num).toDouble(),
      maxsupply: (json['CoinInfo']['MaxSupply'] as num).toDouble(),
      openday: (json['RAW']['USD']['OPENDAY'] as num).toDouble(),
      highday: (json['RAW']['USD']['HIGHDAY'] as num).toDouble(),
      lowday: (json['RAW']['USD']['LOWDAY'] as num).toDouble(),
      changepct: (json['RAW']['USD']['CHANGEPCT24HOUR'] as num).toDouble(),
      marketcap: json['DISPLAY']['USD']['MKTCAP'] as String,
      totalvolume24h: json['DISPLAY']['USD']['TOTALVOLUME24HTO'] as String,


    );
  }
}