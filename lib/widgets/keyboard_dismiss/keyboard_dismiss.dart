import 'package:flutter/widgets.dart';

class KeyboardDismiss extends StatelessWidget {
  final Widget child;

  const KeyboardDismiss({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
