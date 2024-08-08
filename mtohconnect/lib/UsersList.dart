
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtohconnect/constant/Routes.dart';
import 'package:mtohconnect/main.dart';
import 'package:mtohconnect/services/auth/auth_servies.dart';

class Userslist extends StatefulWidget {
  const Userslist({super.key});

  @override
  State<Userslist> createState() => _UserslistState();
}

class _UserslistState extends State<Userslist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
       actions: [
        PopupMenuButton<Menuaction>(
          onSelected:(value) async{
          switch(value){
          
            case Menuaction.logout:
            bool shouldlogout=await ShowLOgoutDialog(context);
            if(shouldlogout){
             await  Authservies.firrebase().Logout();
              Navigator.of(context).pushNamedAndRemoveUntil(Loginroute, (route)=>false);

            }
            else
            {
            Navigator.of(context).pop();
            }

              // TODO: Handle this case.
          }
        },
        
        itemBuilder:(context) {
          return[
          const PopupMenuItem<Menuaction>(
            value: Menuaction.logout,
          child: Text('logout'),
          ),
          ];
        },
       )
        ]
      ),
    );
  }
  
  
}
Future<bool> ShowLOgoutDialog(BuildContext context){
return showDialog<bool>(context: context,
 builder: (context){
  return AlertDialog(title: Text('Sign Out!!'),
  content:Text('Are you sure you want to Sign Out??') ,
  actions: [
    ElevatedButton(onPressed: (){
      Navigator.of(context).pop(true);
    }, child: Text('Yes'),),
    ElevatedButton(onPressed:(){
        Navigator.of(context).pop(true);
    }, child: Text('Cancel'),),
  ],);


}
).then((value) => value ?? false,);

}
