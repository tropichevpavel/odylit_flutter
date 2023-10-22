import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageNetCache extends StatefulWidget
{
	final String? url;
	final Function? errorCallback;
	final double? width;
	final double? height;
	const ImageNetCache(this.url, { this.width, this.height, this.errorCallback, super.key });

	@override
	State<StatefulWidget> createState() => _ImageNetCacheState();
}

class _ImageNetCacheState extends State<ImageNetCache>
{
	bool isError = false;

	Widget onError(context, url, error)
	{
		if (widget.errorCallback != null) widget.errorCallback!();
		if (!isError) WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => isError = true));
		return const SizedBox.shrink();
	}

	@override
	Widget build(BuildContext context) =>
	CachedNetworkImage(
		width: !isError ? widget.width ?? double.infinity : 0,
		height: !isError ? widget.height ?? double.infinity : 0,
		imageUrl: widget.url ?? '',
		// progressIndicatorBuilder: (context, url, progress) => CircularProgressIndicator(),
		errorWidget: onError,
		fit: BoxFit.cover,
	);
}
