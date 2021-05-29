import 'dart:math';

import 'package:crypto_currency/scrrens/home_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrenciesScreen extends StatefulWidget {
  bool is_true;
   final coinDetail;

  CurrenciesScreen({@required this.is_true, @required this.coinDetail});

  @override
  _CurrenciesScreenState createState() =>
      _CurrenciesScreenState(is_true, coinDetail);
}

class _CurrenciesScreenState extends State<CurrenciesScreen> {
  final PageController _pageController = PageController();
  double _curentPosition = 0;
  bool is_true;
  final coinDetail;
  double changeRate;
  double yesterdayPrice;

  Color color;
  Color changecolor;
    _CurrenciesScreenState(this.is_true, this.coinDetail);

  @override
  void initState() {
    // TODO: implement initState
    _pageController.addListener(() {
      _curentPosition = _pageController.page;
      setState(() {});
    });
    super.initState();
    _color();
    CalculateRate();
  }

  void _color(){
    if(coinDetail.change > 0){
      color = Colors.green;
    }else if(coinDetail.change == 0){
      color = Colors.orange;
    }else{
      color = Colors.redAccent;
    }
  }
  void CalculateRate(){
   if(coinDetail.changepct > 0){
     changecolor = Colors.green;
   }else if(coinDetail.changepct == 0){
     changecolor = Colors.orange;
   }else{
     changecolor = Colors.redAccent;
   }
  }

  int size = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              is_true ? Colors.white : Color(0XFF5F627D),
              is_true ? Colors.white : Color(0XFF5F627D)
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Your Coins'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),

              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.002)
                  ..rotateY(pi * _curentPosition),
                child: Container(
                  margin: EdgeInsets.only(top: 24, bottom: 18),
                  height: 150,
                  width: double.infinity,
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
              ),
              Expanded(
                child: ListView.builder(

                  itemCount: 1,
                  itemBuilder: (context, index) => Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: double.infinity,
                          child: ListView.separated(
                              itemBuilder: (context, index) => ListTile(
                                    title: Text(coinDetail.fullName,style: TextStyle(fontSize: 20)),
                                    subtitle: Text(coinDetail.name,style: TextStyle(fontSize: 14,color: Colors.black87)),
                                    trailing: Text('\$${coinDetail.price.toStringAsFixed(4)}\n'+ '\%${coinDetail.changepct.toStringAsFixed(4)}',style: TextStyle(fontSize: 18, color: changecolor)),


                                  ),
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: 1),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(child: Text('\t Market Cap  ${coinDetail.marketcap}',style: TextStyle(fontSize: 16,letterSpacing: 1,height: 1.3),),),
                                    Expanded(child: Text('\t Max Supply ${coinDetail.maxsupply}',style: TextStyle(fontSize: 16,color: Colors.black,letterSpacing: 1,height: 1.3),),),
                                    Expanded(child: Text('\t Change ${'\$'+coinDetail.change.toStringAsFixed(4)}',style: TextStyle(fontSize: 16,letterSpacing: 1,height: 1.3),),),
                                    Expanded(child: Text('\t  24H Volume  ${coinDetail.totalvolume24h}',style: TextStyle(fontSize: 16,letterSpacing: 1,height: 1.3),),),
                                    Expanded(child: Text('\t Open Day\t ${'\$'+coinDetail.openday.toStringAsFixed(4)}',style: TextStyle(fontSize: 16,letterSpacing: 1,height: 1.3),),),
                                    Expanded(child:Text('\t High Day ${'\$'+coinDetail.highday.toStringAsFixed(4)}',style: TextStyle(fontSize: 16,letterSpacing: 1,height: 1.3),),),
                                    Expanded(child: Text('\t Low Day ${'\$'+coinDetail.lowday.toStringAsFixed(4)}',style: TextStyle(fontSize: 16,letterSpacing: 1,height: 1.3),),),













                                  ],
                                ),
                              ),
                            ],
                          ),
                          ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}


