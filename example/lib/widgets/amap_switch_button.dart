import 'package:flutter/material.dart';

typedef void OnChanged(bool value);

class AMapSwitchButton extends StatefulWidget {
  const AMapSwitchButton({
    Key? key,
    this.label,
    this.onSwitchChanged,
    this.defaultValue = true,
  }) : super(key: key);

  final Text? label;
  final Function? onSwitchChanged;
  final bool defaultValue;

  @override
  State<StatefulWidget> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<AMapSwitchButton> {
  late bool _localValue;
  @override
  void initState() {
    super.initState();
    _localValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.label!,
              Switch(
                value: _localValue,
                onChanged: (null != widget.onSwitchChanged)
                    ? (value) {
                        setState(() {
                          _localValue = value;
                        });
                        widget.onSwitchChanged!(value);
                      }
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
