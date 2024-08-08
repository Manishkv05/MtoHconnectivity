

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtohconnect/constant/Routes.dart';

class emailverfication extends StatefulWidget {
  const emailverfication({super.key});

  @override
  State<emailverfication> createState() => _emailverficationState();
}

class _emailverficationState extends State<emailverfication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mail verfication'),backgroundColor: Colors.amberAccent,),
      body: Column(children: [  
        Text('Verification Email has been sent click on that to get verified',style: TextStyle(fontSize: 25),),
      
        TextButton(onPressed: () async {
           final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
      
      
        }, child: Text('Click if havent recived verification link yet '),),
         TextButton(onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(Loginroute, (route)=>false);
      
                 }, child: Text("verified through the link  ? Click here to LOGIN"),),
                 TextButton(onPressed: () async{
                         await  FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(Loginroute, (route)=>false);
                 }, child: Text('reset'))
      
      
      ],),
    );
  }
}