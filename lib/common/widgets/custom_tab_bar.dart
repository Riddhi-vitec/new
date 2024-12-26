import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/font_size.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/radius.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/style.dart';

class CustomTabBar {
  static AppBar customTabBarScroller(
      {required BuildContext context,
      required int noOfTabs,
      required TabController tabController}) {
    return AppBar(
      backgroundColor: Colors.pink,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(cardRadius),
              bottomLeft: Radius.circular(cardRadius))),
      bottom: TabBar(
          controller: tabController,
          physics: const ClampingScrollPhysics(),
          isScrollable: true,
          indicator: BoxDecoration(
              color: Colors.lightGreenAccent,
              borderRadius: BorderRadius.circular(8)),
          tabs: List.generate(noOfTabs, (index) {
            return SizedBox(
              child: Center(
                child: Text(
                  'Tab $index',
                  style: Style.tabBarTitleStyle(isSelected: true),
                ),
              ),
            );
          })),
    );
  }

  static Expanded customTabBarView(
      {required List<Widget> children, required TabController tabController}) {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: children,
      ),
    );
  }
}

/**
    1. You will have to use a stateful widget
    2. Extend with SingleTickerProviderStateMixin like this:
    class DummyState extends State<DummyView> with SingleTickerProviderStateMixin
    3. Don't forget to declare, numberOfTabs a TabTabController and initialize inside initState like this:
    @override
    void initState() {
    super.initState();
    _tabController = TabController(length: numberOfTabs, vsync: this);
    _tabController?.addListener(() {
    _dummyBloc.add(TriggerDummyEvent(tabController: _tabController!));
    });
    }
    4. add the end don't forget to dispose like this
    @override
    void dispose() {
    _tabController!.dispose();
    super.dispose();
    }
 */
