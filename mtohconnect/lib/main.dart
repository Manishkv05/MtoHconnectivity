
import 'package:flutter/material.dart';
import 'package:mtohconnect/UsersList.dart';
import 'package:mtohconnect/constant/Routes.dart';
import 'package:mtohconnect/firebase_options.dart';
import 'package:mtohconnect/loginscreen.dart';

import 'package:mtohconnect/registerscreen.dart';
import 'package:mtohconnect/services/auth/auth_servies.dart';
import 'package:mtohconnect/verify_email.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Homepage(),
      routes: {
        Registerroute:(context)=>const Registerscreen(),
        Loginroute:(context)=> Loginscreen(),
        Emailverficationroute:(context)=> emailverfication(),
        Userlistroute:(context)=>Userslist(),
      }
    );
  }
}
enum Menuaction {logout}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Authservies.firrebase().Initialize(),
        builder: (context, snapshot)  {
          switch (snapshot.connectionState){
            
         
            case ConnectionState.done:
              final user = Authservies.firrebase().currentUser;
              if(user!=null){
              if(user.isEmailverified){
              return const Userslist();
              }else{
                // Navigator.of(context).pushAndRemoveUntil('/emailverfication/' as Route<Object?>, (route)=>false);
                return const emailverfication();
              }
              }else{
                return Loginscreen();
              
              }
            
          
         
          
          
               default:
            return LinearProgressIndicator();

          }
    
        },
        );
  }
}
