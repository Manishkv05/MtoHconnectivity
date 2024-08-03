import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mtohconnect/firebase_options.dart';

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
      appBar: AppBar(title: Text("user registration"),backgroundColor: Colors.amberAccent,),
      body: FutureBuilder(
        future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot)  {
          switch (snapshot.connectionState){
            
         
            case ConnectionState.done:
             return Container(
         
          height: MediaQuery.of(context).size.height*0.5,
          child: Column(
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
                final UserCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                print(UserCredential);
        
                
          
              },
               child: Text('Register'))
            ],
          ),
      );
            default:
            return LinearProgressIndicator();

          }
    
        },
        ),
      
    );
  }
}