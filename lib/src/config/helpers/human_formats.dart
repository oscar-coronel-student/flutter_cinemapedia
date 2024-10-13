import 'package:intl/intl.dart';

class HumanFormats {

  static String format( double number ){
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en'
    ).format(number);
    return formattedNumber;
  }

}