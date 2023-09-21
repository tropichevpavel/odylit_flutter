
import 'package:odylit/entities/Content.dart';

import 'utils/api.dart';

abstract class core
{
	static Map<String, List<Content>> categoryContent = {};

	static _getContentCards(String cat) async => convertData((await api.getContentCards(cat))['data'], (j) => Content.fromJSON(j)).cast<Content>();

	static getContentCards(String cat, { bool refresh = false }) async => refresh || categoryContent[cat] == null ? categoryContent[cat] = await _getContentCards(cat) : categoryContent[cat];

	static preloadContentCards(List<String> cats) => cats.forEach((cat) => cat != 'main' ? getContentCards(cat) : null);

	static handler (Map<String, dynamic> response, Function onSuccess, [Function? onError])
	{
		if (199 < response['status'] && response['status'] < 299)
		{
			return onSuccess(response['data']);
		}
		else if (399 < response['status'] && response['status'] < 501)
		{
			if (onError != null) { return onError(response['message']); }
		}
	}

	static List<dynamic> convertData (List<dynamic> data, Function convert)
	{
		List<dynamic> convertData = [];
		for (var row in data) { convertData.add(convert(row)); }
		return convertData;
	}
}
