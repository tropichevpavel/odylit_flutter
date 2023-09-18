import 'package:flutter/material.dart';
import 'pages/MainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
	MyApp({Key? key}) : super(key: key) { WidgetsFlutterBinding.ensureInitialized(); }

	@override
	Widget build(BuildContext context) => MaterialApp(home: const MainPage() ); // theme: ThemeData(useMaterial3: true),
}