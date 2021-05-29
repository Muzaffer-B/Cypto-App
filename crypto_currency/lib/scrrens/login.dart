import 'package:crypto_currency/models/walletcrypto.dart';
import 'package:crypto_currency/scrrens/Register.dart';
import 'package:crypto_currency/scrrens/home_screen.dart';
import 'package:crypto_currency/scrrens/news.dart';
import 'package:flutter/material.dart';
class Login extends StatefulWidget {

  final walletlist;
  bool is_true;
  Login({@required this.walletlist,this.is_true});

  @override
  _LoginState createState() => _LoginState(walletlist,is_true);
}

class _LoginState extends State<Login> {

  List<WalletCrypto> coinlist = new List();

  final walletlist;
  bool is_true;
  _LoginState(this.walletlist,this.is_true);

  bool check = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    is_true = check;
    coinlist = walletlist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF5F627D),
      body: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top:80,left: 40,right: 40),
            child: Container(

              width: double.infinity,
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.only(left:15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child:  TextField(
                        decoration:  InputDecoration(
                          border: InputBorder.none,
                          hintText: 'E-Mail',

                        ),
                      ),
                    ),
                    Container(
                      child:  TextField(
                        decoration:  InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',

                        ),
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          child: Text('Giriş Yap'),
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            padding: EdgeInsets.only(left: 20,right: 50),
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => home_screen(walletlist: coinlist,is_true: check),
                              ),
                            );
                          }, ),
                        TextButton(
                          child: Text('Üye Ol'),
                          style: TextButton.styleFrom(
                            primary: Colors.redAccent,
                            padding: EdgeInsets.only(left:15,right: 5)
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            );
                          }, )
                      ],
                    )

                  ],
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }
}
