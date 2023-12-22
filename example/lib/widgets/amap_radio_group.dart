import 'package:amap_map_example/widgets/amap_gridview.dart';
import 'package:flutter/material.dart';

class AMapRadioGroup<T> extends StatefulWidget {
  final String? groupLabel;
  final T? groupValue;
  final Map<String, T>? radioValueMap;
  final ValueChanged<T>? onChanged;
  AMapRadioGroup(
      {Key? key,
      this.groupLabel,
      this.groupValue,
      this.radioValueMap,
      this.onChanged})
      : super(key: key);

  @override
  _AMapRadioGroupState createState() => _AMapRadioGroupState();
}

class _AMapRadioGroupState extends State<AMapRadioGroup> {
  dynamic _groupValue;

  @override
  void initState() {
    super.initState();
    _groupValue = widget.groupValue ?? null;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> radioList = <Widget>[];
    _groupValue = widget.groupValue ?? null;
    Widget _myRadio(String label, dynamic radioValue) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          Radio<dynamic>(
            value: radioValue,
            groupValue: _groupValue,
            onChanged: (_value) {
              setState(() {
                _groupValue = _value;
              });
              if (null != widget.onChanged) {
                widget.onChanged!(_value);
              }
            },
          ),
        ],
      );
    }

    if (widget.radioValueMap != null) {
      widget.radioValueMap!.forEach((key, value) {
        radioList.add(_myRadio(key, value));
      });
    }
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.groupLabel!),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: AMapGradView(
              childrenWidgets: radioList,
            ),
          ),
        ],
      ),
    );
  }
}
