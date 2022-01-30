import 'dart:math';

import 'package:flash_chat/helpers/string_helper.dart';
import 'package:flash_chat/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlphaInputBox extends ConsumerWidget {
  final TextEditingController controller;

  final String hintText;
  final StateProvider provider;
  final double rounding;
  final TextInputType keyboard;
  final double width;

  const AlphaInputBox(
      {Key? key,
      required this.controller,
      this.hintText = "",
      required this.provider,
      this.keyboard = TextInputType.text,
      this.width = double.infinity,
      this.rounding = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("$hintText rebuild ${Random().nextInt(100)}");
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Focus(
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  ref.read(provider.notifier).state =
                      controller.value.text.isAlphabetOnly;
                } //if leave disable warning
              },
              child: TextField(
                enableInteractiveSelection: false,
                onChanged: (value) {
                  if (!ref.read(provider.notifier).state) {
                    ref.read(provider.notifier).state = value.isAlphabetOnly;
                  } //if leave disable warning
                },
                autofocus: false,
                controller: controller,
                keyboardType: keyboard,
                decoration: InputDecoration(
                  hintText: hintText,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(rounding),
                    borderSide: BorderSide(
                      color: Themes.primaryColor.withOpacity(0.6),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(rounding),
                    borderSide: const BorderSide(
                      color: Themes.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            if (!ref.watch(provider.state).state)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Text(
                  "$hintText is not valid",
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
