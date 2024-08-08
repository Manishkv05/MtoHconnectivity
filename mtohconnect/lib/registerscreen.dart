



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtohconnect/constant/Routes.dart';

import 'package:mtohconnect/services/auth/auth_exceptions.dart';
import 'package:mtohconnect/services/auth/auth_servies.dart';
import 'package:mtohconnect/utiites/show_error_dialog.dart';

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
                 final UserCredential= await Authservies.firrebase().Login(email: email, password: password);
          
                 final user = Authservies.firrebase().currentUser;
                   if(user?.isEmailverified ?? false)
                Authservies.firrebase().sendEmailVerification();
                   
        
            Navigator.of(context).pushNamedAndRemoveUntil(Emailverficationroute, (route)=>false);


               }on EmailaleAdyinuse{
                     Showerrordialog(context,'Email already used try with login/resetpassword');  
               }on WeakpPassword{
                 Showerrordialog(context,'Weak password--Password should be at least 6 characters'); 
               }on InvalidEmailAddresss{
                  Showerrordialog(context,'Invalid email');
               }on GenericException{
                 Showerrordialog(context,'Failed register'); 

               }
            
              },
               child: Text('Register')),
               TextButton(onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(Loginroute, (route)=>false);

               }, child: Text("Already registered ? Click to LOGIN"))
            ],
          ),
      
    );
  }
}