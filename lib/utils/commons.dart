import 'package:flutter/material.dart';

void log(String msg) => debugPrint('-> $msg');

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
  String toTrim(int maxLength, [String marker = '...']) =>
      trim().length > maxLength ? trim().substring(0, (maxLength - 1)) + marker : trim();
  String toInitials() {
    String result = "";
    List<String> words = split(" ");
    for (var element in words) {
      if (element.isNotEmpty && result.length < 2) {
        result += element[0];
      }
    }
    return result.trim().toUpperCase();
  }
}

class Utility {
  static bool isEmpty(String? o) => o == null || "" == o || o.trim().isEmpty;
  static bool isNotEmpty(String? o) => !isEmpty(o);
  static bool isNullOrZero(int? value) => value == null || value < 1;
  static bool isEmptyList(List? list) => list == null || list.isEmpty;

  static String includePath(String path) {
    if (path.endsWith('/')) return path;
    if (path.endsWith('\\')) return path;
    return path + '/';
  }

  static bool isNumeric(String? s) {
    if (s == null) return false;
    return double.tryParse(s) != null;
  }

  static String list2Csv(List<dynamic> list, String separator) {
    if (isEmptyList(list)) return '';
    var s = list[0].toString();
    for (int i = 1; i < list.length; i++) {
      s += separator + list[i].toString();
    }
    return s;
  }

  // 0.0 - 1.0
  static double getPercent(int? actual, int? total) {
    if (actual == null || total == null) return 0.0;
    if (actual > total) return 1.0;
    if (total == 0) return 0.0;

    double result = ((actual.toDouble() / total.toDouble()) * 100) / 100;
    return result;
  }

  static String eliminateFirstWord(String word, String src) =>
      (src.toLowerCase().startsWith(word)) ? src.substring(word.length, src.length) : src;
}
