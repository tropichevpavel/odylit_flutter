import 'package:flutter/material.dart';

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
		child: Container(
			width: double.infinity,
			height: 400,
			decoration: const 
			BoxDecoration(
				image: DecorationImage(
					image: AssetImage('assets/images/main_header.jpg'),
					fit: BoxFit.fill
				)
			)));

	List<Widget> _drawTabs()
	{
		List<Widget> list = [];
		for (final tab in tabs)
		{
			list.add(Tab(text: tab.name, icon: tab.icon));
		}
		return list;
	}

	Widget _drawTabBarView()
	{
		List<Widget> list = [];
		for (final tab in tabs)
		{
			list.add(ContentList(tab.id));
		}
		return TabBarView(children: list);
	}

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
					unselectedLabelColor: const Color(0xFF949494),
					tabs: _drawTabs()
				)),
			body: Stack(
				children: [
					_drawBackgroungHeader(),
					_drawTabBarView()
				])));
}