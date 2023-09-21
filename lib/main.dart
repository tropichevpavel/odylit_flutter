import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/MainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget
{
	MyApp({super.key}) { WidgetsFlutterBinding.ensureInitialized(); }

	@override
	State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
	@override
	void initState()
	{
		super.initState();
		SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
	}

	@override
	Widget build(BuildContext context) => MaterialApp(home: MainPage());
}
