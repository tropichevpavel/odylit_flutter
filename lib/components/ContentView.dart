import 'dart:io';
import 'package:flutter/material.dart';
import 'package:linkwell/linkwell.dart';
import 'package:odylit/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../entities/Content.dart';
import './ImageNetCache.dart';
import './WebViewPlayer.dart';
import '../theme.dart';
import 'TextMinLines.dart';

const BTN_MORE_DEFAULT_LABEL = 'Подробнее';

class ContentView extends StatelessWidget
{
	final Content data;
	final bool isFull;
	final double fontSize = 15;
	const ContentView(this.data, { this.isFull = false, super.key });

	Widget? _drawImage(BuildContext context) => data.img != null ?
	ImageNetCache(data.img, width: theme.getContentListImageWidth(context, isFull: isFull), height: theme.getContentListImageHeight(context, isFull: isFull), errorCallback: () => data.img = null) : null;

	Widget? _drawVideoPlayer() => isFull && data.video != null && (Platform.isAndroid || Platform.isIOS) ?
	WebViewPlayer(data.video!) : null;

	Widget? _drawMedia(context) => data.img != null ?
	Container(
		width: theme.getContentListImageWidth(context, isFull: isFull),
		height: theme.getContentListImageHeight(context, isFull: isFull),
		margin: const EdgeInsets.only(bottom: 7),
		child:ClipRRect(
			borderRadius: BorderRadius.circular(8.0),
			child: Stack(
				children: [
					_drawImage(context),
					_drawVideoPlayer()
				].whereType<Widget>().toList()
			)))

	: null;

	Widget _drawTitle(context) =>
	Container(
		margin: const EdgeInsets.only(top: 8, bottom: 10),
		alignment: Alignment.center,
		child: TextWithMinLines(
			data.title,
			minLines: isFull ? 0 : utils.isTablet(context) ? 3 : 1,
			maxLines: isFull ? null : 3,
			textAlign: TextAlign.center,
			overflow: isFull ? null : TextOverflow.ellipsis,
			style: TextStyle(height: 1.2, fontSize: fontSize, fontWeight: FontWeight.bold)));


	int getDescriptionTextLines(BuildContext context) => utils.isTablet(context) ? (theme.getContentListImageHeight(context, isFull: isFull) / ((fontSize - 2) * 1.2)).round() - 1 : 3;

	Widget? _drawDescription(context) => data.descr != null ? isFull ?
	Container(
		margin: const EdgeInsets.only(bottom: 10),
		child: LinkWell(
			data.descr!,
			textAlign: TextAlign.justify, style: TextStyle(fontSize: fontSize - 2, height: 1.3, color: Colors.black),
			linkStyle: TextStyle(fontSize: fontSize - 2, height: 1.3, decoration: TextDecoration.underline, color: Colors.blue)))

	: data.img == null ?

	Container(
		height: utils.isTablet(context) ? theme.getContentListImageHeight(context, isFull: isFull) : null,
		margin: const EdgeInsets.only(bottom: 10),
		child: Center(child: Text(data.descr!, maxLines: getDescriptionTextLines(context), style: TextStyle(height: 1.2, fontSize: fontSize - 2, color: const Color(0xFF515151)))))

		// child:  TextWithMinLines(data.descr!, minLines: utils.isTablet(context) ? 8 : 1, maxLines: utils.isTablet(context) ? 8 : 3, style: TextStyle(height: 1.2, fontSize: fontSize - 2, color: const Color(0xFF515151))))

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
			child: Text( data.linkBtn ?? BTN_MORE_DEFAULT_LABEL)))

	: null;

	@override
	Widget build(BuildContext context) =>
	Padding(
		padding: !isFull ? const EdgeInsets.all(10) : utils.isTablet(context) ? const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20) : const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 16),
		child: Column(
			children: [
				_drawMedia(context),
				_drawTitle(context),
				_drawDescription(context),
				_drawDate(),
				_drawBtnMore()
			].whereType<Widget>().toList()
		));
}
