import 'package:flutter/material.dart';
import 'package:odylit/theme.dart';

import '../utils/utils.dart';

const double MARGIN_BOTTOM = 100;

void showResizebleBottomSheet(BuildContext context, Widget body)
{
	final keyContent = GlobalKey();
	final screenHeigth = MediaQuery.of(context).size.height;

	bool isChange = false;
	double initialChildSize = 1;
	double maxChildSize = 1;
	double minChildSize = 1;

	double marginBottom = 0;

	void setRigthHeigth(double? height)
	{
		if (height == null) return;

		marginBottom = (height + MARGIN_BOTTOM) > screenHeigth || !utils.isTablet(context) ? 0 : MARGIN_BOTTOM;

		maxChildSize = (height + marginBottom) / screenHeigth;
		if (maxChildSize > 1)
		{
			initialChildSize = 0.8;
			maxChildSize = 1;
			minChildSize = 0.6;
		}
		else
		{
			initialChildSize = maxChildSize;
			minChildSize = maxChildSize > 0.5 ? 0.5 : (maxChildSize - 0.01);
		}

		isChange = true;	
	}

	showModalBottomSheet(
		context: context,
		useRootNavigator: true,
		isScrollControlled: true,
		backgroundColor: Colors.transparent,
		// shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
		builder: (context) =>
		StatefulBuilder(builder: (BuildContext context, StateSetter setStateModal)
		{
			if (!isChange)
			{
				WidgetsBinding.instance.addPostFrameCallback((_) => setStateModal(() => setRigthHeigth(keyContent.currentContext?.size?.height)));
			}

			final Size handleSize = Theme.of(context).bottomSheetTheme.dragHandleSize ?? const Size(32, 4);
			final Color handleColor = Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.4);

			return Stack(
				children: [
					Positioned.fill(child: GestureDetector(onTap: () => Navigator.pop(context))),
					Container(
						margin: EdgeInsets.only(left: utils.isTablet(context) ? theme.getTabletHorizontalMargin(context) : 0, right: utils.isTablet(context) ? theme.getTabletHorizontalMargin(context) : 0), //bottom: utils.isTablet(context) ? MediaQuery.of(context).size.height / 10 : 0),
						decoration: BoxDecoration(
							color: (marginBottom != 0) ? Colors.transparent : Colors.white,
							borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
						child:
						DraggableScrollableSheet(
							initialChildSize: initialChildSize,
							minChildSize: minChildSize,
							maxChildSize: maxChildSize,
							expand: false,
							builder: (context, controller) =>
							ScrollConfiguration(
								behavior: ScrollBehaviorNoGlow(),
								child:
								ListView(
									controller: controller,
									physics: const ClampingScrollPhysics(),
									shrinkWrap: true,
									children: [
										Wrap(
											key: keyContent,
											children: [
												Container(
													decoration: BoxDecoration(
														color: Colors.white,
														borderRadius: (marginBottom != 0) ? const BorderRadius.all(Radius.circular(10)) : const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
													child: Wrap(
														children: [
															Container(
																width: double.infinity,
																padding: const EdgeInsets.only(top: 10),
																alignment: Alignment.center,
																child: Container(
																	height: handleSize.height,
																	width: handleSize.width,
																	decoration: BoxDecoration(
																		borderRadius: BorderRadius.circular(handleSize.height / 2),
																		color: handleColor
																	))),
															body
														])),
												SizedBox(height: marginBottom, child: GestureDetector(onTap: () => Navigator.pop(context)))
											],
										)
									]
								))))
				]);
		}));
}
