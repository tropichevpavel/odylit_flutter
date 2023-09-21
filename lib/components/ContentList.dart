import 'package:flutter/material.dart';

import 'ContentCard.dart';
import '../entities/Content.dart';

import '../core.dart';
import 'ContentListHeader.dart';

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

	@override
	Widget build(BuildContext context1) =>
	RefreshIndicator(
		onRefresh: () => _loadContentCards(refresh: true),
		child: ListView.builder(
			itemCount: _cards.length + 1,
			itemBuilder: (BuildContext context, int index) => index == 0 ? ContentListHeader(widget.category) : ContentCard(_cards[index - 1])
		));
}
