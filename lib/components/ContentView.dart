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
	const ContentView(this.data, { this.isFull = false, super.key });

	Widget? _drawImage() => data.img != null ?
	ImageNetCache(data.img, errorCallback: () => data.img = null) : null;

	Widget? _drawVideoPlayer() => isFull && data.video != null && (Platform.isAndroid || Platform.isIOS) ?
	WebViewPlayer(data.video!) : null;

	Widget _drawTitle() =>
	Container(
		margin: const EdgeInsets.only(top: 15, bottom: 10),
		alignment: Alignment.center,
		child: Text(
			data.title,
			textAlign: TextAlign.center,
			style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));

	Widget? _drawDescription() => isFull && data.descr != null ?
	LinkWell(
		data.descr!,
		textAlign: TextAlign.justify, style: const TextStyle(fontSize: 16, color: Colors.black),
		linkStyle: const TextStyle(fontSize: 16, decoration: TextDecoration.underline, color: Colors.blue))

	: null;

	Widget _drawDate() =>
	Container(
		alignment: Alignment.centerRight,
		child: Text(data.date.getDMY(), style: const TextStyle(color: Color(0xFF515151))));

	Widget? _drawBtnMore() => isFull && data.link != null ?
	Container(
		alignment: Alignment.center,
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
				ClipRRect(
					borderRadius: BorderRadius.circular(8.0),
					child: Stack(
						children: [
							_drawImage(),
							_drawVideoPlayer()
						].whereType<Widget>().toList()
					)),
				_drawTitle(),
				_drawDescription(),
				_drawDate(),
				_drawBtnMore()
			].whereType<Widget>().toList()
		));
}