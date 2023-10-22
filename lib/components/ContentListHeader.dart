import 'package:flutter/material.dart';

import '../theme.dart';

class ContentListHeader extends StatelessWidget
{
	final String category;
	const ContentListHeader(this.category, {super.key});
	
	@override
	Widget build(BuildContext context) =>
	Container(
		margin: const EdgeInsets.symmetric(vertical: 15),
		alignment: Alignment.topCenter,
		child: Image.asset('assets/img/title_$category.png', width: theme.getContentWidth(context) * 4 / 5),
	);
}
