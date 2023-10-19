import 'package:flutter/material.dart';

class QuestionDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function()pressed;
  const QuestionDialog({required this.title,required this.message, required this.pressed,super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:160, 
      child:Padding(
        padding:const EdgeInsets.symmetric(horizontal:16,vertical: 8),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize:20,
              )
            ),
            const SizedBox(height:10),
            Text(
              message,
              style:Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize:18,
                fontWeight: FontWeight.w400
              )
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  style:const ButtonStyle(
                    overlayColor: MaterialStatePropertyAll<Color>(Colors.transparent)
                  ),
                  child:Text(
                    "Cancel",
                    style:Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize:16,
                      fontWeight: FontWeight.w500
                    ) 
                  )
                ),
                const SizedBox(width:10),
                ElevatedButton(
                  onPressed: pressed,
                  style:ElevatedButton.styleFrom(
                    backgroundColor:const Color.fromRGBO(111, 111, 198, 1) 
                  ),
                  child:Text(
                    "Yes",
                    style:Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize:16,
                      fontWeight: FontWeight.w500,
                      color:Colors.white
                    ) 
                  )
                )
              ],
            )
          ],
        ),
      )
    );
  }
}