import 'package:flutter/material.dart';
import 'pages/MainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
	MyApp({Key? key}) : super(key: key) { WidgetsFlutterBinding.ensureInitialized(); }

	@override
	Widget build(BuildContext context) => const MaterialApp(home: MainPage() );
}