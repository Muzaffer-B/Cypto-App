

import 'package:crypto_currency/scrrens/Register.dart';
import 'package:crypto_currency/scrrens/login.dart';
import 'package:flutter/material.dart';
class Profile extends StatefulWidget {

  final walletlist;
  bool is_true;
  Profile({@required this.walletlist,this.is_true});

  @override
  _ProfileState createState() => _ProfileState(walletlist,is_true);
}

class _ProfileState extends State<Profile> {

  final walletlist;
  bool is_true;
  _ProfileState(this.walletlist,this.is_true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    is_true = true;

  }


  _profile_complete(){


    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){

          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),

            title: Text('Profil oluşturmadınız.'),

            actions: <Widget>[

              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: MaterialButton(
                  child: Text('Profil Oluştur'),
                  shape: StadiumBorder(),
                  minWidth: 100,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    );

                  },
                ),
              ),
              MaterialButton(

                shape: StadiumBorder(),
                minWidth: 100,
                child: Text('Üye olmadan devam et'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0XFF5F627D),
        // ignore: deprecated_member_use
        body:  Login(walletlist: walletlist,is_true: is_true),
       /* Column(
          children: [


            Padding(
              padding: EdgeInsets.only(top: 20,left: 145),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage('https://hivlawcommission.org/wp-content/uploads/2016/04/Business-man-1.png'),
              ),
            ),
          ],
        ),*/
      ),
    );

  }


}
