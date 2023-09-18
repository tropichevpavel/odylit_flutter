import 'package:flutter/material.dart';

import 'ContentCard.dart';
import '../entities/Content.dart';

import '../core.dart';

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
	initState()
	{
		super.initState();
		_cards = core.categoryContent[widget.category] ?? [];
		if (_cards.isEmpty) _loadContentCards();
	}

	_loadContentCards() async
	{
		_cards = await core.getContentCards(widget.category);
		core.categoryContent[widget.category] = _cards;

		setState(() {});
	}

	@override
	Widget build(BuildContext context) =>
	RefreshIndicator(
		onRefresh: () => _loadContentCards(),
		child: ListView.builder(
			itemCount: _cards.length + 1,
			itemBuilder: (BuildContext context, int index) => index == 0 ? Image.asset('assets/images/category_${widget.category}.png') : ContentCard(_cards[index - 1])
		));
}