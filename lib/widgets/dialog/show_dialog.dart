import 'package:flutter/material.dart';
void showDialogBox(BuildContext context,Widget child){
  showDialog(context:context,builder: (context)=>Dialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      child:child
    )
  );
}