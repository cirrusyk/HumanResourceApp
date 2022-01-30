import 'package:flash_chat/theme/theme_constants.dart';
import 'package:flash_chat/widgets/fancy_password_input_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final validProvider = StateProvider((ref) => true);

class PasswordInputBox extends ConsumerWidget {
  final TextEditingController controller;
  final double rounding;
  final bool isVisible;
  final String hinttext;
  final bool Function() func;

  const PasswordInputBox(
      {Key? key,
      required this.controller,
      this.isVisible = true,
      required this.hinttext,
      required this.func,
      this.rounding = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool _isValid = ref.watch(validProvider);
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Focus(
              onFocusChange: (hasFocus) =>
                  ref.read(validProvider.notifier).state = true &&
                      controller.value.text.isEmpty, //if leave disable warning
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                enableInteractiveSelection: false,
                controller: controller,
                onChanged: (_) =>
                    _isValid = func() || controller.value.text.isEmpty,
                obscureText: ref.watch(hiddenProvider.notifier).state,
                decoration: InputDecoration(
                  // suffixIcon: isVisible
                  //     ? Obx(() => GestureDetector(
                  //           onTap: () => SigninController.to.isHidden =
                  //               !SigninController.to.isHidden,
                  //           child: Icon(
                  //             SigninController.to.isHidden
                  //                 ? Icons.visibility
                  //                 : Icons.visibility_off,
                  //             color: ThemeController.to.isDark
                  //                 ? Colors.white.withOpacity(0.87)
                  //                 : Colors.black,
                  //           ),
                  //         ))
                  //     : null,
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
              )),
          if (!_isValid)
            const Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0),
              child: Text(
                "Password does not match",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
    );
  }
}
