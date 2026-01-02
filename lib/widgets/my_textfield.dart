import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? focusnext;
  final String? champ; 
  final double? padding;
  final Color? bordercolor;

  const MyTextfield({super.key,
  required this.hintText,
  required this.obscureText,
  required this.controller,
  this.focusNode,
  this.focusnext,
  this.champ,
  this.padding,
  this.bordercolor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 25, ),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        focusNode: focusNode,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: bordercolor ?? Theme.of(context).colorScheme.primary),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(focusnext);
        },
        validator: (value){
          if(value!.isEmpty){
            return 'Please enter $champ';
          }
        return null;
        },
      ),
    );
  }
} 