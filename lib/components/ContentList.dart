import 'package:flutter/material.dart';

import 'ContentCard.dart';
import '../entities/Content.dart';

import '../core.dart';
import '../theme.dart';
import 'ContentListHeader.dart';

const grid = 3;

class ContentList extends StatefulWidget
{
	final String category;
	const ContentList(this.category, {super.key});

	@override
	State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList>
{
	List<Content> _cards = [];

	@override
	initState() { super.initState(); _loadContentCards(); }

	_loadContentCards({bool refresh = false}) async
	{
		_cards = await core.getContentCards(widget.category, refresh: refresh);
		setState(() {});
	}

	List<Widget> getRowWiedget(int row, int colums)
	{
		final startIndex = row * colums;
		final List<Widget> list = [];

		for (int i = 0; i < grid; ++i)
		{
			list.add(Expanded(child: _cards.length > startIndex + i ? ContentCard(_cards[startIndex + i]) : const SizedBox.shrink()));
		}

		return list;
	}

	Widget gridList(int colums) =>
	ScrollConfiguration(behavior: const ScrollBehavior(), child:
	GlowingOverscrollIndicator(
		axisDirection: AxisDirection.down,
        color: const Color(0xFFD6455C),
		child:
		ListView.builder(
			itemCount: (_cards.length / colums).ceil() + 1,
			itemBuilder: (context, index) => index == 0 ? ContentListHeader(widget.category) : Container(margin: const EdgeInsets.only(right: 16), child: colums == 1 ? ContentCard(_cards[index - 1]) : Row(children: getRowWiedget(index - 1, colums))))));

	// Widget gridListTrue(int colums) =>
	// GridView.builder(
	// 	gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: colums),
	// 	itemCount: _cards.length + 1,
	// 	itemBuilder: (context, index) => index == 0 ? ContentListHeader(widget.category) : ContentCard(_cards[index - 1]));

	@override
	Widget build(BuildContext context) =>
	RefreshIndicator(
		onRefresh: () => _loadContentCards(refresh: true),
		child: gridList(theme.getContentListCount(context)));
}
