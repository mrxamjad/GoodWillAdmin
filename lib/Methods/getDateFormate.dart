import 'package:intl/intl.dart';

String getDateFormate(String strDate) {
  DateTime date = DateTime.parse(strDate);
  return DateFormat("h:mm a  MMMM,dd  yyyy").format(date);
}
