import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mtohconnect/firebase_options.dart';
import 'package:mtohconnect/loginscreen.dart';

import 'package:mtohconnect/registerscreen.dart';

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
        '/register/':(context)=>const Registerscreen(),
        '/login/':(context)=> Loginscreen(),
        '/emailverfication/':(context)=>emailverfication(),
      }
    );
  }
}
class Homepage extends StatelessWidget {
  const Homepage({super.key});

 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot)  {
          switch (snapshot.connectionState){
            
         
            case ConnectionState.done:
           
           return Loginscreen();
         
          
          
               default:
            return LinearProgressIndicator();

          }
    
        },
        );
  }
}


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