import 'package:crypto_currency/models/walletcrypto.dart';
import 'package:crypto_currency/scrrens/login.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
class Wallet extends StatefulWidget {

  final coinlistt;
  final walletpricee;
   Wallet({@required this.coinlistt,@required this.walletpricee});
  @override
  _WalletState createState() => _WalletState(coinlistt,walletpricee);
}

class _WalletState extends State<Wallet> {

  _WalletState(this.coinlistt,this.walletpricee);

  List<WalletCrypto> coinlist = new List();
  final coinlistt;
  final walletpricee;
  double walletprice = 10000;
  double updateprice;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    coinlist = coinlistt;

    Login(walletlist: coinlist,is_true: true);

    walletprice = walletpricee;
    //AlreadyBuy();
  }

  @override
  Widget build(BuildContext context) {
    return coinlist!=null ? Container(
      color: Colors.grey,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 20)),
          Text('Wallet',style: TextStyle(fontSize: 20),),
          Padding(padding: EdgeInsets.only(top: 20)),
          Text('\$${walletprice.toString()}',style: TextStyle(fontSize: 20),),
          Expanded(

              child: ListView.builder(
                  padding: EdgeInsets.all(7),
                  itemCount: coinlist.length,
                  itemBuilder: (BuildContext context, int index){
                    return AlreadyBuy() == true ? Card(

                      child: ListTile(
                        leading:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                          ],
                        ),
                        title:Text(
                          coinlist[index].name,
                          style: TextStyle(fontSize: 16,
                              color: Colors.black),
                        ),
                        subtitle: Text(
                          coinlist[index].adet.toString(),
                          style: TextStyle(fontSize: 14,color: Colors.black),
                        ),
                        trailing:Text(
                          '\$${coinlist[index].price.toString()}',
                        ),
                      ),
                    ): UpdateCoin() == true ? CreateCard():null;

              })
          )
        ],
      ),
    ): Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Center(
        child: Column(
          children: [
            Text('Wallet',style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }

   AlreadyBuy(){
    print('giriyor');
    print(coinlist.length);
    int i,j;
    if(coinlist.length>2){
      for(i=0;i<coinlist.length;i++){
        for(j=1;j<coinlist.length;j++){
          j++;
          print(j);

            if(coinlist[i].name == coinlist[j].name){
              print('false girdi');
              return false;
            }else{
              print(i);
              print(j);
              print(coinlist[i].name);
              print(coinlist[j].name);

              print('true girdi');
              return true;
            }

        }
      }
    } /*if(coinlist.length>2){
      for(i=0;i<coinlist.length;i++){
        for(j=0;j<coinlist.length;j++){

          if(coinlist[i].name == coinlist[j].name){
            print('Girdiii');
            return false;
          }



        }
      }
    }*/ else return true;

  }

  UpdateCoin(){
    int i,j;
    print('Update girdi');
    if(coinlist.length>2){
      for(var i=0;i<coinlist.length;i++){
        for(var j=1;j<coinlist.length;j++){
          j++;
          if(coinlist.length > 2){
            if(coinlist[i].name == coinlist[j].name){

                 coinlist[i].price += coinlist[j].price;
                 updateprice = coinlist[i].price;
                 coinlist[j].price = updateprice;
                 coinlist.removeAt(i);
                 print(coinlist.length);
                 break;


            }
          }


        }
      }
        return true;

    }

  }

  CreateCard(){
    print('create card girdi');
    return Card(

      child: ListTile(
        leading:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
        title:Text(
          coinlist[coinlist.length-2].name,
          style: TextStyle(fontSize: 16,
              color: Colors.black),
        ),
        subtitle: Text(
          coinlist[coinlist.length-2].adet.toString(),
          style: TextStyle(fontSize: 14,color: Colors.black),
        ),
        trailing:Text(
          '\$${coinlist[coinlist.length-2].price.toString()}',
        ),
      ),
    );
  }
}




