import 'package:intl/intl.dart';

class HumanFormats {

  static String format( double number, [ int decimalDigits = 0 ] ){
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      symbol: '',
      locale: 'en'
    ).format(number);
    return formattedNumber;
  }

}