
extension DateTimeExtension on DateTime {
  bool isSameDay(DateTime date){
    return day== date.day && month == date.month && year == date.year;
  }


  ///This method converts difference between two dates into time ago format
  ///This method is having an optional parameter which handles weather outputs will contain numeric values of difference
  static String getTimeAgo({DateTime? firstDate,
    DateTime? secondDate,
    bool numericDates = true}) {
    final first = firstDate ?? DateTime.now();
    final second = secondDate ?? DateTime.now();
    final difference = first.difference(second);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }


}

