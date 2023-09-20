import 'package:flutter/material.dart';
import 'package:odylit/components/ContentView.dart';

import '../entities/Content.dart';
import './ResizebleBottomSheet.dart';

class ContentCard extends StatelessWidget
{
	final Content data;
	const ContentCard(this.data, {super.key});

	@override
	Widget build(BuildContext context) =>
	GestureDetector(
		onTap: () => showResizebleBottomSheet(context, ContentView(data, isFull: true)),
		child: Card(
			margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
			color: const Color(0xFFF4F4F4),
			elevation: 4.0,
			child: ContentView(data)
		));
}
