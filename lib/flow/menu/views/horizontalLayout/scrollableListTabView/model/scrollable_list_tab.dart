import 'package:flutter/cupertino.dart';

import 'listTab.dart';

class ScrollableListTab {
  final ListTab? tab;
  final ScrollView? body;

  ScrollableListTab({this.tab, this.body})
      : assert(
            body!.shrinkWrap && body.physics is NeverScrollableScrollPhysics);
}
