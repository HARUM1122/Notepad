import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({required this.message,super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:160, 
      child:Padding(
        padding:const EdgeInsets.symmetric(horizontal:16,vertical: 8),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            const SizedBox(height:20),
            Text(
              message,
              style:Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize:18,
                fontWeight: FontWeight.w400
              )
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: ()=>Navigator.pop(context),
                style:ElevatedButton.styleFrom(
                  backgroundColor:const Color.fromRGBO(111, 111, 198, 1) 
                ),
                child:Text(
                  "Ok",
                  style:Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize:16,
                    fontWeight: FontWeight.w500,
                    color:Colors.white
                  ) 
                )
              ),
            )
          ],
        ),
      )
    );
  }
}