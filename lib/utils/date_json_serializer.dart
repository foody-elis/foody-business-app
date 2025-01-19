import 'package:intl/intl.dart';

final _dateFormatter = DateFormat('yyyy-MM-dd');
DateTime dateFromJson(String date) => _dateFormatter.parse(date);
String dateToJson(DateTime date) => _dateFormatter.format(date);
