import 'package:flutter/material.dart';
import 'package:flutter_hiennv/constants/app_textstyles.dart';

class EmptyWidget extends StatelessWidget {
  final String _status;
  final String _buttonText;
  final bool _isShowImage;
  final Widget _imageEmpty;
  final VoidCallback? _callback;

  EmptyWidget({
    required Key key,
    String? status,
    String? buttonText,
    bool? isShowImage,
    Widget? imageEmpty,
    VoidCallback? onTap,
  })  : _status = status ?? '',
        _buttonText = buttonText ?? '',
        _isShowImage = isShowImage ?? true,
        _imageEmpty = imageEmpty ?? Icon(Icons.image),
        _callback = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (_isShowImage) _imageEmpty,
        SizedBox(
          height: 20.0,
        ),
        Text(_status, style: regularTextStyle()),
        SizedBox(
          height: 20.0,
        ),
        if (_buttonText.isNotEmpty)
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              overlayColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered))
                    return Colors.blue.withOpacity(0.04);
                  if (states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.pressed))
                    return Colors.blue.withOpacity(0.12);
                  return Colors.blue;
                },
              ),
            ),
            onPressed: () {
              if (_callback != null) {
                _callback!();
              }
            },
            child: Container(
              height: 44.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_buttonText, style: regularTextStyle(height: 1.0))
                ],
              ),
            ),
          ),
        SizedBox(
          height: 80.0,
        ),
      ],
    );
  }
}
