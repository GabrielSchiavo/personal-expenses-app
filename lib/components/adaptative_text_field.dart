import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onSubmitted;

  final Widget? suffixIcon;
  final String? hintText;

  const AdaptativeTextField({
    this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onSubmitted,
    this.suffixIcon,
    this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 18,
            ),
            child: CupertinoTextField(
                controller: controller,
                keyboardType: keyboardType,
                onSubmitted: onSubmitted,
                placeholder: label,
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 12,
                )),
          )
        : TextField(
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              labelText: label,
              suffixIcon: suffixIcon,
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.normal,
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.outline,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              focusColor: Theme.of(context).colorScheme.primary,
            ),
          );
  }
}
