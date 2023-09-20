import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewPlayer extends StatefulWidget
{
	final String url;
	const WebViewPlayer(this.url, {Key? key}) : super(key: key);

	@override
	State<WebViewPlayer> createState() => _WebViewPlayerState();
}

class _WebViewPlayerState extends State<WebViewPlayer>
{
	late final WebViewController _controller;
	double _opacity = 0.0;

	@override
	void initState()
	{
		super.initState();

		late final PlatformWebViewControllerCreationParams params;
		if (WebViewPlatform.instance is WebKitWebViewPlatform)
		{
			params = WebKitWebViewControllerCreationParams( allowsInlineMediaPlayback: true, mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{});
		}
		else
		{
			params = const PlatformWebViewControllerCreationParams();
		}

		final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
		controller..setJavaScriptMode(JavaScriptMode.unrestricted)
				  ..setNavigationDelegate(
						NavigationDelegate(
							onProgress: (int progress) => debugPrint('WebView is loading (progress : $progress%)'),
							onPageStarted: (String url) => debugPrint('Page started loading: $url'),
							// onPageFinished: (String url) => setState(() => _opacity = 1.0)))
						))
				  ..loadRequest(Uri.parse(widget.url));

		if (controller.platform is AndroidWebViewController)
		{
			AndroidWebViewController.enableDebugging(true);
			(controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(true);
		}

		_controller = controller;
		Future.delayed(const Duration(seconds: 5), () => setState(() => _opacity = 1.0));
	}

	Widget? _drawProggressBar() => _opacity == 0 ? const
	Positioned.fill(
		child: Align(
			alignment: Alignment.bottomCenter,
			child: LinearProgressIndicator()))

	: null;

	@override
	Widget build(BuildContext context) =>
	Stack(children: [
		Opacity(
			opacity: _opacity,
			child: SizedBox(
				width: MediaQuery.of(context).size.width,
				height: MediaQuery.of(context).size.width * 0.5,
				child: WebViewWidget(controller: _controller))),
		_drawProggressBar()
	].whereType<Widget>().toList()) ;
}

