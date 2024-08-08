

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mtohconnect/constant/Routes.dart';
import 'package:mtohconnect/services/auth/auth_exceptions.dart';
import 'package:mtohconnect/services/auth/auth_servies.dart';
import 'package:mtohconnect/utiites/show_error_dialog.dart';


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
                
                final UserCredential= Authservies.firrebase().Login;
                print(UserCredential);
               
                  final user = Authservies.firrebase().currentUser;
                   if(user?.isEmailverified ?? false){
            Navigator.of(context).pushNamedAndRemoveUntil(Userlistroute , (route)=>false);
            }else{
            Navigator.of(context).pushNamedAndRemoveUntil(Emailverficationroute, (route)=>false);
            }
            
              }on UsernotFound{
                    Showerrordialog(context,'User not found');
              }on WrongPassword{
                  Showerrordialog(context,'Wrong password');  
              }on GenericException{
                   Showerrordialog(context,'Something went Wrong: Failed to login!!'); 
              }
              
          
        
                
          
              },
               child: Text('LOGIN')),
                 
               TextButton(onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(Registerroute, (route)=>false);

               }, child: Text("Not yet registered ? Click to Register"),
               ),

            ],
          ),
      
    );
  }
}