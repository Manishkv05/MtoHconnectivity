

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        Text('Please verify your Email',style: TextStyle(fontSize: 25),),
      
        TextButton(onPressed: () async {
           final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
      
      
        }, child: Text('Snd verification link to your email'),),
         TextButton(onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route)=>false);
      
                 }, child: Text("Done verification through the link  ? Click to LOGIN"))
      
      
      ],),
    );
  }
}