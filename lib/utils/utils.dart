
import 'package:flutter/material.dart';

abstract class utils
{
	static bool isTablet(context) => MediaQuery.of(context).size.shortestSide >= 600;
}

class ScrollBehaviorNoGlow extends ScrollBehavior
{
	@override
	Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) => child;
}
