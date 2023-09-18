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
			margin: const EdgeInsets.all(20),
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
			color: const Color(0xFFF4F4F4),
			elevation: 8.0,
			child: ContentView(data)
		));
}
