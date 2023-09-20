import 'package:flutter/material.dart';

class ContentListHeader extends StatelessWidget
{
	final String category;
	const ContentListHeader(this.category, {super.key});
	
	@override
	Widget build(BuildContext context) =>
	Container(
		margin: const EdgeInsets.symmetric(vertical: 15),
		alignment: Alignment.topCenter,
		child: Image.asset('assets/img/title_$category.png', width: MediaQuery.of(context).size.width * 4 / 5),
	);
}
