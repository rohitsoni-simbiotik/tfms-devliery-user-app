import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {
  String toNormalCase() {
    try {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    } catch (e) {
      return this;
    }
  }
}

extension DateTimeExtensions on DateTime {
  DateTime get onlyDateTime {
    return DateTime(year, month, day);
  }

  String get dateMMMddyyyy {
    return DateFormat('MMM dd yyyy').format(this);
  }

  String get dateString {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String get dayString {
    return DateFormat('EEEE').format(this);
  }

  String get monthString {
    return DateFormat('MMMM').format(this);
  }

  String get timeString {
    return DateFormat('hh:mm aa').format(this);
  }

  String get apiString {
    return DateFormat('dd/MM/yyyy hh:mm aa').format(this);
  }
}

extension DioResponseExtension on Response {
  bool get isSuccess {
    final statusCode = this.statusCode ?? 0;
    return this.statusCode! >= 200 && statusCode < 300;
  }
}
