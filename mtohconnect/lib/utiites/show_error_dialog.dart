import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void Showerrordialog(BuildContext context,String errortext){
  showDialog(context: context, 
  builder:(context) {
    return AlertDialog(
      title: Text('Something went wrong'),
      content:  Text(errortext),
      actions: [
         TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('OK'),),
      ],
    );
    
  },);
}