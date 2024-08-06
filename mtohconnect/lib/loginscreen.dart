import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';


class Loginscreen extends StatefulWidget {
   Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  late final TextEditingController _email;

  late final TextEditingController _password;

  @override
  void initState() {
   _email=TextEditingController();
   _password=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
   _email.dispose();
   _password.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LOGIN HERE"),backgroundColor: Colors.amberAccent,),
      body: Column(
            children: [
              TextField(
                keyboardType:TextInputType.emailAddress,
                autocorrect:false,
                enableSuggestions:false,
                controller:_email,
                decoration: InputDecoration(
                  hintText: 'Enter your mail address'
                ),
                
          
          
              ),
              TextField(
                   keyboardType:TextInputType.visiblePassword,
                autocorrect:false,
                enableSuggestions:false,
                obscureText: true,
                controller:_password,
                 decoration: InputDecoration(
                  hintText: 'Enter your Password'
                ),
                
          
              ),
              TextButton(onPressed:  () async{
                  final email=_email.text;
                final password=_password.text;
                
              try{
                
                final UserCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                print(UserCredential);
               
                  final user = FirebaseAuth.instance.currentUser;
                   if(user?.emailVerified ?? false){
            Navigator.of(context).pushNamedAndRemoveUntil('/Userlist/' , (route)=>false);
            }else{
            Navigator.of(context).pushNamedAndRemoveUntil('/emailverfication/', (route)=>false);
            }
              }on FirebaseAuthException catch(e){
                 if(e.code=='user-not-found'){
                  print('no User data found ');
                  
                 }else if(e.code=='wrong-password'){
                  print('Wrong password');
                 }

              }
              catch(e){
                print('Something wrong happened');
              }
        
                
          
              },
               child: Text('LOGIN')),
                 
               TextButton(onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil('/register/', (route)=>false);

               }, child: Text("Not yet registered ? Click to Register"),
               ),

            ],
          ),
      
    );
  }
}