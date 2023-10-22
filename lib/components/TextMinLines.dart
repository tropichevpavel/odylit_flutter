
import 'package:flutter/material.dart';

class TextWithMinLines extends Text
{
	final int minLines;

	const TextWithMinLines(super.data,
	{
		super.key, 
		super.style, 
		super.strutStyle, 
		super.textAlign,
		super.textDirection, 
		super.locale,
		super.softWrap,
		super.overflow, 
		super.textScaleFactor, 
		this.minLines = 0,
		super.maxLines, 
		super.semanticsLabel, 
		super.textWidthBasis, 
		super.textHeightBehavior,
	}
	) : assert(minLines >= 0), super();

	@override
	Widget build(BuildContext context)
	{
    	final displayText = super.build(context);
		if (minLines < 2 || style == null || style!.height == null || style!.fontSize == null) return displayText;

		return Container(
			height: style!.height! * style!.fontSize! * minLines,
			alignment: Alignment.center,
			child: displayText);
  }
}