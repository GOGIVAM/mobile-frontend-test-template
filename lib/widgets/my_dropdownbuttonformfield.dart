import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyDropdownbuttonformfield extends StatefulWidget {
  //text when there is no choice yet 
  final String? hintText;
  //for the message in case of no choice during the submission 
  final String? champ; 
  final List<String> choices;
  final String? valueStart;
  final double? radius;
  final double? padding;
  final Function(String?)? onChanged;


  const MyDropdownbuttonformfield({super.key,
    this.hintText,
    this.champ,
    required this.choices,
    this.valueStart,
    this.radius,
    this.padding,
    required this.onChanged});

  @override
  State<MyDropdownbuttonformfield> createState() => _MyDropdownbuttonformfieldState();
}

class _MyDropdownbuttonformfieldState extends State<MyDropdownbuttonformfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 25.0, ),
      child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 10)),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 10)),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                  ),
                  fillColor: Theme.of(context).colorScheme.secondary,
                  filled: true,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                value: widget.valueStart,
                items: widget.choices.map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        ))
                    .toList(),
                onChanged: widget.onChanged,
                validator: (value) =>
                  value == null ? 'Please choose a ${widget.champ}' : null,
              ),
    );
  }
}