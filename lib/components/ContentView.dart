import 'dart:io';
import 'package:flutter/material.dart';
import 'package:linkwell/linkwell.dart';
import 'package:url_launcher/url_launcher.dart';

import '../entities/Content.dart';
import './ImageNetCache.dart';
import './WebViewPlayer.dart';

class ContentView extends StatelessWidget
{
	final Content data;
	final bool isFull;
	final double fontSize = 15;
	const ContentView(this.data, { this.isFull = false, super.key });

	Widget? _drawImage() => data.img != null ?
	ImageNetCache(data.img, errorCallback: () => data.img = null) : null;

	Widget? _drawVideoPlayer() => isFull && data.video != null && (Platform.isAndroid || Platform.isIOS) ?
	WebViewPlayer(data.video!) : null;

	Widget? _drawMedia() => data.img != null ?
	Container(
		margin: const EdgeInsets.only(bottom: 7),
		child:ClipRRect(
			borderRadius: BorderRadius.circular(8.0),
			child: Stack(
				children: [
					_drawImage(),
					_drawVideoPlayer()
				].whereType<Widget>().toList()
			)))

	: null;

	Widget _drawTitle() =>
	Container(
		margin: const EdgeInsets.only(top: 8, bottom: 10),
		alignment: Alignment.center,
		child: Text(
			data.title,
			textAlign: TextAlign.center,
			style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)));

	Widget? _drawDescription() => data.descr != null ? isFull ?
	Container(
		margin: const EdgeInsets.only(bottom: 10),
		child: LinkWell(
			data.descr!,
			textAlign: TextAlign.justify, style: TextStyle(fontSize: fontSize - 2, height: 1.3, color: Colors.black),
			linkStyle: TextStyle(fontSize: fontSize - 2, height: 1.3, decoration: TextDecoration.underline, color: Colors.blue)))

	: data.img == null ?

	Container(
		margin: const EdgeInsets.only(bottom: 10),
		child: Text(data.descr!, maxLines: 3, style: TextStyle(fontSize: fontSize - 2, color: const Color(0xFF515151))))

	: null : null;

	Widget _drawDate() =>
	Container(
		alignment: Alignment.centerRight,
		child: Text(data.date.getDMonthY(), style: const TextStyle(color: Color(0xFF515151))));

	Widget? _drawBtnMore() => isFull && data.link != null ?
	Container(
		alignment: Alignment.center,
		margin: const EdgeInsets.only(top: 5),
		child: ElevatedButton(
			onPressed: () async => await launchUrl(Uri.parse(data.link!)),
			child: const Text('Подробнее')))

	: null;

	@override
	Widget build(BuildContext context) =>
	Padding(
		padding: const EdgeInsets.all(10),
		child: Column(
			children: [
				_drawMedia(),
				_drawTitle(),
				_drawDescription(),
				_drawDate(),
				_drawBtnMore()
			].whereType<Widget>().toList()
		));
}
