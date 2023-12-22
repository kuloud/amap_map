import 'package:flutter/cupertino.dart';

///demo的模板类
abstract class BasePage extends StatelessWidget {
  final String title;
  final String subTitle;

  const BasePage(this.title, this.subTitle);
}
