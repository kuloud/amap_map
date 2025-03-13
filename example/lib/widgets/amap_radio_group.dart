import 'package:amap_map_example/widgets/amap_gridview.dart';
import 'package:flutter/material.dart';

class AMapRadioGroup<T> extends StatefulWidget {
  final String? groupLabel;
  final T? groupValue;
  final Map<String, T>? radioValueMap;
  final ValueChanged<T?>? onChanged;
  AMapRadioGroup(
      {super.key,
      this.groupLabel,
      this.groupValue,
      this.radioValueMap,
      this.onChanged});

  @override
  State<AMapRadioGroup<T>> createState() => _AMapRadioGroupState<T>();
}

class _AMapRadioGroupState<T> extends State<AMapRadioGroup<T>> {
  T? _groupValue;

  @override
  void initState() {
    super.initState();
    _groupValue = (widget.groupValue);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> radioList = <Widget>[];
    _groupValue = (widget.groupValue);
    Widget myRadio(String label, dynamic radioValue) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(label),
          Radio<T>(
            value: radioValue,
            groupValue: _groupValue,
            onChanged: (T? value) {
              setState(() {
                _groupValue = value;
              });
              widget.onChanged!(value);
            },
          ),
        ],
      );
    }

    if (widget.radioValueMap != null) {
      widget.radioValueMap!.forEach((String key, value) {
        radioList.add(myRadio(key, value));
      });
    }
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(widget.groupLabel!),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: AMapGradView(
              childrenWidgets: radioList,
            ),
          ),
        ],
      ),
    );
  }
}
