import 'package:intl/intl.dart';

import '../../imports/common.dart';




String extractDateOnlyFromDateTime(DateTime dateTime){
  String formattedTime =  DateFormat.yMMMd().format(dateTime);
  return formattedTime;
}

String extractTimeOnlyFromDateTime(DateTime dateTime){
  String formattedTime = DateFormat.Hm().format(dateTime);
  return formattedTime;
}

DateTime convertStringToDateTime({required String date}){
  RegExp dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}(T\d{2}:\d{2}:\d{2}(\.\d{1,3})?Z)?$');
  return dateRegex.hasMatch(date)? DateTime.parse(date): DateTime.now();
}

String convertDateTimeToString({required DateTime dateTime, required DateTimeFormatForApiResponse format}){
  switch (format) {
    case DateTimeFormatForApiResponse.utc:
      return dateTime.toUtc().toIso8601String(); // Format: "2023-02-04T00:00:00.000Z"
    case DateTimeFormatForApiResponse.nonUtc:
      return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}"; // Format: "2023-05-05"
    default:
      throw ArgumentError("Invalid format specified");
  }
}




String notificationTimeStamp(String timeStr) {
  DateTime givenTime = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").parse(timeStr);
  DateTime currentTime = DateTime.now();
  Duration timeDifference = currentTime.difference(givenTime);

  if (timeDifference < const Duration(hours: 12)) {
    int minutesDiff = timeDifference.inMinutes;
    if (minutesDiff < 60  && minutesDiff > 0) {
      return "$minutesDiff mins ago";
    } else if(minutesDiff == 0){
      return "Just now";
    }
    else {
      int hoursDiff = (minutesDiff / 60).floor();
      return "$hoursDiff hrs ago";
    }
  } else {
    return DateFormat("hh:mm a MM/dd/yyyy").format(givenTime);
  }
}