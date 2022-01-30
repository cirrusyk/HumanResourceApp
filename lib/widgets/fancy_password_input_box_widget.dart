import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../helpers/regex_helper.dart';
import '../theme/theme_constants.dart';

final strengthProvider = StateProvider((ref) => 0);
final hiddenProvider = StateProvider((ref) => false);

class FancyPasswordInputBox extends ConsumerWidget {
  final TextEditingController controller;
  final double rounding;
  final bool isVisible;
  final String hinttext;

  const FancyPasswordInputBox(
      {Key? key,
      required this.controller,
      this.isVisible = true,
      required this.hinttext,
      this.rounding = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool _isHidden = ref.watch(hiddenProvider);
    return Container(
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            enableInteractiveSelection: false,
            controller: controller,
            onChanged: (_) => ref.read(strengthProvider.notifier).state =
                CustomRegExp().strengthpassword(controller.value.text),
            obscureText: _isHidden,
            decoration: InputDecoration(
              suffixIcon: isVisible
                  ? GestureDetector(
                      onTap: () =>
                          ref.read(hiddenProvider.notifier).state = !_isHidden,
                      child: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                        // color: ThemeController.to.isDark
                        //     ? Colors.white.withOpacity(0.87)
                        //     : Colors.black,
                        color: Colors.black,
                      ),
                    )
                  : null,
              hintText: hinttext,
              labelStyle: const TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(rounding),
                borderSide: const BorderSide(
                  color: Themes.primaryColor,
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
          const SizedBox(
            height: 10,
          ),
          Row(
            children: List.generate(
                5,
                (index) => Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                          color: ref.read(strengthProvider.notifier).state >=
                                  index + 1
                              ? [
                                  Colors.transparent, // never used
                                  Colors.red.withOpacity(0.8),
                                  Colors.deepOrange.withOpacity(0.8),
                                  Colors.orange,
                                  Colors.greenAccent.withOpacity(0.9),
                                  Colors.green,
                                ][ref.read(strengthProvider.notifier).state]
                              //: ThemeController.to.isDark
                              : true
                                  ? Colors.grey.withOpacity(0.2)
                                  : Colors.transparent,
                          border: Border.all(color: Colors.black, width: 0.5)),
                      height: 10,
                      width: MediaQuery.of(context).size.width / 4 - 48,
                    )).toList(),
          )
        ]));
  }
}
