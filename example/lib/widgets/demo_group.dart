import 'package:amap_map_example/base_page.dart';
import 'package:flutter/material.dart';

class DemoGroupWidget extends StatefulWidget {
  final String groupLabel;
  final List<BasePage>? itemPages;

  DemoGroupWidget({Key? key, required this.groupLabel, this.itemPages})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _GroupState();
}

class _GroupState extends State<DemoGroupWidget> {
  void _pushPage(BuildContext context, BasePage page) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (_) => Scaffold(
              appBar: AppBar(title: Text(page.title)),
              body: page,
            )));
  }

  bool _hasItemPages = false;
  @override
  void initState() {
    super.initState();
    if (widget.itemPages != null && widget.itemPages!.length > 0) {
      _hasItemPages = true;
    } else {
      _hasItemPages = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
            title: Text(
          widget.groupLabel,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        )),
        Divider(height: 1),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: _hasItemPages
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.itemPages!.length,
                  itemBuilder: (_, int index) => ListTile(
                    title: Text(widget.itemPages![index].title),
                    subtitle: Text(widget.itemPages![index].subTitle),
                    onTap: () => _pushPage(context, widget.itemPages![index]),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    height: 1,
                    indent: 16,
                  ),
                )
              : null,
        ),
        Divider(height: 1),
      ],
    );
  }
}
