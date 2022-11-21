part of 'shared.dart';

class Helper{
  static String toIdr(var mount){
    final currencyFormatter = NumberFormat.simpleCurrency(locale: 'id_ID');
    return currencyFormatter.format(mount);
  }
}