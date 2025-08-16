import 'package:flutter/material.dart';
class CustomeWidgites extends StatelessWidget {
  CustomeWidgites({super.key, this.hinttext, this.onchanged,this.obscureText=false});
 final String? hinttext;
  Function(String)? onchanged;
 bool ? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data)
      {
        if(data! .isEmpty)
        {
     return 'Field Is Required';
        }
        return null;
      },
      onChanged: onchanged,
      decoration: InputDecoration(
          hintText: hinttext,
          hintStyle:const TextStyle(
            color: Colors.white,
          ),
          enabledBorder:const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )
          )
      ),
    );
  }
}
