import 'package:flutter/material.dart';

import '../utils/utils.dart';

abstract class theme
{
	static double getTabletHorizontalMargin(context) => (MediaQuery.of(context).size.width / 6);

	static double getContentWidth(context) => MediaQuery.of(context).size.width - (utils.isTablet(context) ? getTabletHorizontalMargin(context) + 40 : 0);

	static int getContentListCount(context) => utils.isTablet(context) ? 3 : 1;

	static double getContentListImageWidth(context, { isFull = false }) => isFull ? getContentWidth(context) : MediaQuery.of(context).size.width / getContentListCount(context);
	static double getContentListImageHeight(context, { isFull = false }) => getContentListImageWidth(context, isFull: isFull) * 0.5;
}