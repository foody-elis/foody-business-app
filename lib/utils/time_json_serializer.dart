import 'package:intl/intl.dart';

final _timeFormatter = DateFormat('HH:mm');

DateTime? timeFromJsonNullable(String? time) => time == null ? null : _timeFormatter.parse(time);
String? timeToJsonNullable(DateTime? time) => time == null ? null : _timeFormatter.format(time);

DateTime timeFromJson(String time) => _timeFormatter.parse(time);
String timeToJson(DateTime time) => _timeFormatter.format(time);