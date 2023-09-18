import 'package:flutter/material.dart';
import '../components/TabsView.dart';

class MainPage extends StatefulWidget
{
	const MainPage({Key? key}) : super(key: key);

	@override
	State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
{
	List<TabItem> tabs = [
		TabItem('Видео',	 'videos',	Icons.video_camera_back_outlined),
		TabItem('Новости',	 'news',	Icons.newspaper_outlined),
		TabItem('Викторины', 'quiz',	Icons.note_add_outlined),
		TabItem('Контент',	 'content', Icons.article_outlined)
	];

	@override
	Widget build(BuildContext context) => TabsView(tabs);
}

