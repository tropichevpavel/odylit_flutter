
import '../utils/DateTimeExt.dart';
import 'package:html_unescape/html_unescape.dart';

import './Model.dart';

class Content extends Model
{
	int? id;
	String? img;
	String? video;
	String title;
	String? descr;
	DateTimeExt date;
	String? link;

	// ContentCard (this.id, this.title, this.mac, this.bind);

	Content.fromJSON (Map<String, dynamic> json) :
		id = int.parse(json['id']),
		title = HtmlUnescape().convert(json['title']),
		img = (json['img'] == null || json['img'].toString().isEmpty ? null : 'https://festapp.ru/lk/Literary_Odyssey/content/${json['img']}.jpg') ?? json['preview'],
		date = DateTimeExt.fromString(json['timeCreated']),
		video = json['videolink'] != null ? 'https://rutube.ru/play/embed/${json['videolink']}' : null,
		descr = json['about'] != null ? HtmlUnescape().convert(json['about']) : '',
		link = json['link'];
}
