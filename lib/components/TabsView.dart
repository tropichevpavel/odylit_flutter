import 'package:flutter/material.dart';

import 'MainTabView.dart';
import 'ContentList.dart';

class TabItem
{
	String name;
	Icon icon;
	String id;

	TabItem(this.name, this.id, icon) : icon = Icon(icon);
}

class TabsView extends StatelessWidget
{
	final List<TabItem> tabs;
	const TabsView(this.tabs, {super.key});

	Widget _drawBackgroungHeader() =>
	Positioned(
		top: 0,
		right: 0,
		left: 0,
		child: Image.asset('assets/img/bg_main_head.jpg', width: double.infinity, height: 400, fit: BoxFit.fill));

	List<Widget> _drawTabs() => tabs.map((tab) => Tab(text: tab.name, icon: tab.icon)).toList();

	Widget _drawTabBarView() => TabBarView(children: tabs.map((tab) => tab.id == 'main' ? const MainTabView() : ContentList(tab.id)).toList());

	@override
	Widget build(BuildContext context) =>
	DefaultTabController(
		initialIndex: 0,
		length: tabs.length,
		child: Scaffold(
			backgroundColor: Colors.white,
			bottomNavigationBar: 
			Container(
				color: Colors.white,
				child: TabBar(
					dividerColor: Colors.transparent,
					indicatorColor: const Color(0xFFD6455C),
					labelColor: const Color(0xFFD6455C),
					labelPadding: EdgeInsets.zero,
					labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
					unselectedLabelColor: const Color(0xFF949494),
					tabs: _drawTabs()
				)),
			body: Stack(
				children: [
					_drawBackgroungHeader(),
					_drawTabBarView()
				])));
}