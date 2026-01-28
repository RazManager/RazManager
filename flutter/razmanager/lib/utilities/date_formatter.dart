import 'package:intl/intl.dart';

mixin DateFormatter {
  String dateTimeFormat(DateTime dateTime) {
    return DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY).add_Hm().format(dateTime);
    //return DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY, Platform.localeName).add_Hm().format(dateTime);
  }

  String dateOnlyFormat(DateTime dateTime) {
    return DateFormat(DateFormat.YEAR_MONTH_DAY).format(dateTime);
    //return DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY, Platform.localeName).add_Hm().format(dateTime);
  }
}
