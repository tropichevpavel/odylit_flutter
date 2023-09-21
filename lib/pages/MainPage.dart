import 'package:flutter/material.dart';
import '../components/TabsView.dart';

// import '../core.dart';

class MainPage extends StatelessWidget
{
	final List<TabItem> tabs =
	[
		TabItem('Главная',	 'main',	Icons.home_outlined),
		TabItem('Видео',	 'videos',	Icons.video_camera_back_outlined),
		TabItem('Новости',	 'news',	Icons.newspaper_outlined),
		TabItem('Викторины', 'quiz',	Icons.description_outlined), // description_outlined // note_add_outlined // find_in_page // live_help //
		TabItem('Контент',	 'content', Icons.article_outlined)
	];

	MainPage({super.key}); // { core.preloadContentCards(tabs.map((tab) => tab.id).toList()); }

	@override
	Widget build(BuildContext context) => TabsView(tabs);
}
