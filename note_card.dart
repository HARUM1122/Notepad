import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  int?id;
  NoteCard({this.id,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:double.infinity,
      height:80,
      child: Card(
        shape:RoundedRectangleBorder(
          side:id!=null?BorderSide(color:const Color.fromRGBO(111, 111, 198, 1)):BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );
  }
}