import 'package:flutter/material.dart';
import 'package:linkwell/linkwell.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../utils/utils.dart';
import '../theme.dart';

import 'ContentListHeader.dart';

const String header =
"""Видоеопутешествие, в котором современные
школьники встречаются с классиками
русской литературы.""";

const String subHeader = 'О ПРОЕКТЕ';
const String description = '«Литературная одиссея» — цикл коллажных видео с использованием анимации о фантастическом путешествии современных школьников в прошлое. Дети попадают в дома писателей-классиков русской и советской литературы. Они могут вживую поговорить за чашкой чая с Иваном Тургеневым, отправиться на конную прогулку с Александром Пушкиным, поймать окуня на рыбалке вместе с Константином Паустовским. А самое главное, задать писателям вопросы о секретах их творчества и прочувствовать «гения места» каждого из них.';

const String contactHeader = 'КОНТАКТЫ';
const String contactWeb = 'https://classmag.ru';
const String contactMail = 'lit_odisseya@osp.ru';

const deltaScrollBackgroundOpacity = 200;

class MainTabView extends StatefulWidget
{
	final double tabViewHeight;
	const MainTabView(this.tabViewHeight, {super.key});

	@override
	State<StatefulWidget> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView>
{
	double _backgrountOpacity = 0;

	bool _onScroll(ScrollMetricsNotification evt)
	{
		setState(() => _backgrountOpacity = evt.metrics.pixels > deltaScrollBackgroundOpacity ? 1 : evt.metrics.pixels < 0 ? 0 : evt.metrics.pixels / deltaScrollBackgroundOpacity);
		return false;
	}

	Widget _scrollMain(context) =>
	SizedBox(
		width: MediaQuery.of(context).size.width,
		height: MediaQuery.of(context).size.height - (widget.tabViewHeight + MediaQuery.of(context).padding.bottom + MediaQuery.of(context).padding.top),
		child: Stack(
			alignment: Alignment.bottomCenter,
			children: [
				Positioned.fill(
					child:
					Center(
						child:
						Padding(
							padding: EdgeInsets.only(top: widget.tabViewHeight == 0 ? 0 : widget.tabViewHeight - MediaQuery.of(context).padding.top),
							child:
							Container(
								padding: const EdgeInsets.all(7),
								decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(theme.getContentWidth(context) / 3 + 7)),
								child: Image.asset('assets/img/logo.png', width: theme.getContentWidth(context) * 2 / 3))))),			
				Column(
					mainAxisSize: MainAxisSize.min,
					children: [
						Center(child: Padding(padding: const EdgeInsets.only(bottom: 20), child: Image.asset('assets/img/grant.png', width: theme.getContentWidth(context) * 3 / 5))),
						const Text(header, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
					],
				),
			],
		),
	);

	Widget _scrollCenter() =>
	Column(
		mainAxisSize: MainAxisSize.min,
		children: [
			Container(
				margin: const EdgeInsets.only(top: 30),
				child: const Text(subHeader, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500))),
			Container(
				margin: EdgeInsets.symmetric(horizontal: utils.isTablet(context) ? theme.getTabletHorizontalMargin(context) : 20, vertical: 20),
				child: RichText(
					textAlign: TextAlign.justify,
					text: const
					TextSpan(
						children: [
							WidgetSpan(child: SizedBox(width: 30.0)),
							TextSpan(text: description, style: TextStyle(height: 1.5, color: Colors.black)),
						])))
			// Text(description, textAlign: TextAlign.center),
		]
	);

	Widget _scrollBottom(context) =>
	Stack(
		children: [
			Positioned.fill(
				child: Align(
					alignment: Alignment.center,
					child: Column(
						mainAxisSize: MainAxisSize.min,
						children: [
							Container(
								margin: const EdgeInsets.only(bottom: 20),
								child: const Text(contactHeader, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500))
							),
							GestureDetector(
								onTap: () => launchUrlString(contactWeb),
								child: const
								Text('$contactWeb\n', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline))),
							GestureDetector(
								onTap: () => launchUrlString('mailto:$contactMail'),
								child: const
								Text(contactMail, style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline))),
						])
				)),
				Image.asset('assets/img/children.png', width: theme.getContentWidth(context) * 1 / 4),
	]);

	@override
	Widget build(BuildContext context) =>
	Stack(
		children: [
			Positioned.fill(
				child: Container(
					margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
					child: const ContentListHeader('main'))),
				Container(
					decoration: BoxDecoration (color: Colors.white.withOpacity(_backgrountOpacity)),
					child: NotificationListener(
						onNotification: _onScroll,
						child:
						ScrollConfiguration(
							behavior: ScrollBehaviorNoGlow(),
							child:
							ListView(
								children: [
									_scrollMain(context),
									_scrollCenter(),
									_scrollBottom(context)
								],
							))))
			]
		);
}
