import 'package:flutask/helpers/utils/colors.dart';
import 'package:flutter/material.dart';

class kAppBar extends StatelessWidget {
   kAppBar({super.key, required this.title, required this.showBackButton, this.actions});

   String? title;
   bool? showBackButton;
   List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.sizeOf(context).width,
      color: Color.fromRGBO(243, 228, 255, 1),
      child: Row(
        children: [
          if(showBackButton!)
          Expanded(
            flex: 1,
            child: 
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
                  ],
                ),
              ),
          Expanded(
            flex: 1,
            child: Center(child: Text(title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),))),
          Expanded(
            flex: 1,
            child: Container(
            ),),
        ],
      ),
    );
  }
}