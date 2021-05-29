import 'package:crypto_currency/models/walletcrypto.dart';
import 'package:crypto_currency/scrrens/home_screen.dart';
import 'package:crypto_currency/scrrens/profile.dart';
import 'package:flutter/material.dart';
class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool is_done2 = true;

  List<WalletCrypto> coinlist = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0XFF5F627D),
        child: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top:80,left: 40,right: 40),
              child: Container(

                width: double.infinity,
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child:  TextField(
                          decoration:  InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Name',

                          ),
                        ),
                      ),

                      Container(
                        child:  TextField(
                          decoration:  InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Surname',

                          ),
                        ),
                      ),
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
                      TextButton(
                        child: Text('Üye Ol'),
                        style: TextButton.styleFrom(
                            primary: Colors.redAccent,
                            padding: EdgeInsets.only(left: 50,right: 50)
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => home_screen(),
                            ),
                          );
                      }, )


                    ],
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );


  }
}
