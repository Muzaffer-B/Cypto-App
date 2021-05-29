

import 'package:crypto_currency/models/walletcrypto.dart';
import 'package:crypto_currency/scrrens/Register.dart';
import 'package:crypto_currency/scrrens/home_screen.dart';
import 'package:crypto_currency/scrrens/wallet.dart';
import 'package:flutter/material.dart';
class Buy_scene extends StatefulWidget {

  final coinDetail;
  final wallet;
  final walletlist;
  bool is_true;

  Buy_scene({@required this.coinDetail, @required this.wallet,@required this.walletlist,@required this.is_true});
  @override
  _Buy_sceneState createState() => _Buy_sceneState(coinDetail,wallet,walletlist,is_true);
}

class _Buy_sceneState extends State<Buy_scene> {

  final coinDetail;
  final wallet;
  final walletlist;
  bool is_true;
  _Buy_sceneState(this.coinDetail,this.wallet,this.walletlist,this.is_true);

  double totalprice =1;

  double adet;
  double walletprice = 10000;

  TextEditingController PriceController = new TextEditingController();

  List<WalletCrypto> coinlist =  new List();
  WalletCrypto Wallett = new WalletCrypto();

    @override
  void initState() {
    // TODO: implement initState
    totalprice = 1;

    is_true = true;

    if(walletlist!=null){
      coinlist = walletlist;
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF5F627D),
      ),
      backgroundColor: Color(0XFF5F627D),
      body: Column(
        children: [
          Flexible(
            child: Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(coinDetail.fullName,style: TextStyle(fontSize: 20)),

                ],
              ),
            ),
          ),

          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top:20.0,bottom: 40),
              child: Flexible(
                child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('\$${coinDetail.price.toStringAsFixed(4)}',style: TextStyle(fontSize: 18))

                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:25.0),
            child: Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 165,
                    width: 100,
                    child: TextField(
                      controller: PriceController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.add,

                        ),
                        hintText: 'adet',
                        hintStyle: TextStyle(
                          fontSize: 20,

                        ),
                      ),
                      onChanged: (string){
                          totalprice = double.parse(PriceController.text);
                          adet = totalprice;
                          print(totalprice);

                          setState(() {
                            printprice(totalprice);
                          });
                      }

                    )
                  ),

                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom:120.0,left: 20),
                      child: printprice(totalprice),
                    ),
                  ),


                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom:120.0,left: 50),
                      child: Expanded(
                        child: Container(
                          height: 50,

                          child: TextButton(
                            onPressed: () {
                              if(wallet < (totalprice*coinDetail.price) ){
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Warning',style: TextStyle(color: Colors.red),),
                                    content: const Text('Wallet price is lower than the desired price.'),
                                    actions: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right:100.0),
                                        child: TextButton(
                                          onPressed: () => Navigator.pop(context, 'OK'),
                                          child: const Text('OK',style: TextStyle(fontSize: 16),),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }else{
                                  setState(() {
                                    Wallett.name = coinDetail.fullName;
                                    Wallett.price = (totalprice*coinDetail.price);
                                    walletprice = walletprice-(totalprice*coinDetail.price);
                                    Wallett.adet = adet;
                                    Wallett.alreadybuy = true;
                                    coinlist.add(Wallett);

                                  });

                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Success',style: TextStyle(color: Colors.red),),
                                      content: const Text('Bought Succesfully'),
                                      actions: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(right:100.0),
                                          child: TextButton(
                                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>home_screen(walletlist: coinlist,is_true: is_true,walletprice: walletprice))),
                                            child: const Text('Go HomeScreen',style: TextStyle(fontSize: 16),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );


                              }
                            },
                            child: Flexible(child: Text('Buy',style: TextStyle(fontSize: 20,color: Colors.green),)),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),



        ],
      ),
    );
  }

  printprice(double price) {

    return Flexible(
      child: Container(

        child: Text(
          //'\$${totalprice.toString()}',
            (totalprice*coinDetail.price).toStringAsFixed(4),
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

/*
() {
                                            var route = new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                              new Wallet(
                                                  coinlistt: coinlist ),
                                            );
                                            Navigator.of(context).push(route);
                                          },
 */