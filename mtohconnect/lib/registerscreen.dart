

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtohconnect/firebase_options.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
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
      appBar: AppBar(title: Text("Register new user"),backgroundColor: Colors.amberAccent,),
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
                 final UserCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                print(UserCredential);
                 final user = FirebaseAuth.instance.currentUser;
                   if(user?.emailVerified ?? false){
             Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route)=>false);
            }else{
            Navigator.of(context).pushNamedAndRemoveUntil('/emailverfication/', (route)=>false);
            }

        
               } on FirebaseAuthException catch(e)
               {
                if(e.code=='email-already-in-use')
                print('Email already used try to login or resetpassword');
                else if(e.code==' weak-password'){

                  print('Password should be at least 6 characters ');
                }
               
               }catch(e){
                print('sommething went wrong');
               }
              
                
          
              },
               child: Text('Register')),
               TextButton(onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route)=>false);

               }, child: Text("Already registered ? Click to LOGIN"))
            ],
          ),
      
    );
  }
}