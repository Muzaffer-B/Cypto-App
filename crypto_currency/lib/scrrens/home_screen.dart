import 'dart:convert';
import 'dart:io';

import 'package:crypto_currency/helper/Loadcrypto.dart';
import 'package:crypto_currency/models/Crypto.dart';
import 'package:crypto_currency/models/walletcrypto.dart';
import 'package:crypto_currency/scrrens/Register.dart';
import 'package:crypto_currency/scrrens/login.dart';
import 'package:crypto_currency/scrrens/news.dart';
import 'package:crypto_currency/scrrens/profile.dart';
import 'package:crypto_currency/scrrens/screen1.dart';
import 'package:crypto_currency/scrrens/settings.dart';
import 'package:crypto_currency/scrrens/wallet.dart';
import 'package:crypto_font_icons/crypto_font_icon_data.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'currencies_screen.dart';
import 'notification.dart';

class home_screen extends StatefulWidget {
  final walletlist;
  bool is_true;
  final walletprice;


  home_screen({@required this.walletlist,@required this.is_true,@required this.walletprice});

  @override
  _home_screenState createState() => _home_screenState(walletlist,is_true,walletprice);
}

bool themeSwitch = false;


class _home_screenState extends State<home_screen> {

  final walletlist;
  bool is_true;
  final walletprice;
  _home_screenState(this.walletlist,this.is_true,this.walletprice);
  bool check = true;


  List<WalletCrypto> coinlist =  List();
  int x;

  var list;
  var refreshkey = GlobalKey<RefreshIndicatorState>();


  //List<Crypto> cryptos = new List<Crypto>();
  // List currencies;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  int coinCounter;
  List<CoinMarket> coins = List();
  List<CoinMarket> filteredCoins = List();

  bool y;

  void initState() {
    super.initState();
    Services.getCoins().then((coinsList) {
      coins = coinsList;
      filteredCoins = coins;
    });

    coinlist = walletlist;
    Login(walletlist: walletlist,is_true: is_true);
    Profile(walletlist: walletlist,is_true: is_true);



    if(is_true != null){
      check = is_true;
      print(check);
      print(coinlist.first.name);
    }


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


  List<Widget>_widgetOptions = <Widget>[
    screen1(),
    Wallet(),
    Profile(),
    settings(),

  ];
  List<String> _appbar = <String>[
    'Portfolio',
    'Wallet',
    'Profile',
    'Settings'
  ];

  @override
  Widget build(BuildContext context) {
    _increment_counter();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [themeColors(), themeColors()]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: themeSwitch ? Colors.white : Color(0XFF5F627D),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(top: 38),

                          height: 75,
                          width: 300,
                          color: themeSwitch ? Colors.white : Color(0XFF5F627D),
                          child:
                          FlatButton(
                            onPressed: () =>
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => news(),
                                  ),
                                ),
                            padding: EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Icon(Icons.new_releases),
                                Text('News', style: TextStyle(fontSize: 20),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: themeSwitch ? Colors.white : Color(0XFF5F627D),
                child: IconButton(
                  iconSize: 40,
                  onPressed: () {
                    setState(() {
                      themeSwitch = !themeSwitch;
                    });
                  },
                  icon: themeSwitch
                      ? Icon(
                    Icons.brightness_3,
                    color: themeSwitch ? Color(0XFF5F627D) : Colors.white,
                  )
                      : Icon(
                    Icons.wb_sunny,
                    color: themeSwitch ? Color(0XFF5F627D) : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(_appbar.elementAt(_currentindex)),
          actions: [
            IconButton(
              icon: Stack(children: [
                Positioned(
                    right: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    )),
                Icon(Icons.notifications_outlined),
              ]),
              onPressed: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => notification(),
                    ),
                  ),
            )
          ],
        ),
        body: _currentindex==0 && check ? screen1(walletlist: coinlist,is_true: check,walletprice: walletprice) :_currentindex==1 && check ? Wallet(coinlistt: coinlist,walletpricee: walletprice,) :_currentindex==2 && check? Profile(walletlist: walletlist,is_true: is_true) : _widgetOptions.elementAt(_currentindex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentindex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 20,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,size: 30,),
              title: Text(''),
              backgroundColor: Colors.black87,

            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.wallet_membership,size: 30),
              title: Text(''),
              backgroundColor: Colors.black87,
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person,size: 30),
              title: Text(''),
              backgroundColor: Colors.black87,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings,size: 30),
              title: Text(''),
              backgroundColor: Colors.black87,
            ),
          ],
          backgroundColor: Colors.black12,
          onTap: (index){
            setState(() {
              _currentindex = index;
            });
          },
        ),

        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
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