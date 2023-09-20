import 'package:flutter/material.dart';

import 'ContentListHeader.dart';

class MainTabView extends StatelessWidget
{
	const MainTabView({super.key});

	@override
	Widget build(BuildContext context) =>
	Container(
		margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
		child: Stack(
			children: [
				const
				Positioned.fill(
					child: ContentListHeader('main')),
				Positioned.fill(
					child: Align(
						alignment: Alignment.center,
						child: Image.asset('assets/img/logo.png', width: MediaQuery.of(context).size.width * 2 / 3))),
				Positioned.fill(
					child: Align(
						alignment: Alignment.bottomCenter,
						child: Image.asset('assets/img/grant.png', width: MediaQuery.of(context).size.width * 2 / 3)))
			]
		));
}