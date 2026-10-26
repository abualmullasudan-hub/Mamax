import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'MAMX';
  static const String devPhone = '0922008009';
  static const String restorePassword = '0922008009';
  
  // المحافظ الافتراضية
  static const String cashWallet = 'cash';
  
  // الأيقونات المتاحة للحسابات (بديل لـ SVG في HTML)
  static const List<IconData> accountIcons = [
    Icons.person,
    Icons.people,
    Icons.face,
    Icons.face_2,
    Icons.face_3,
    Icons.shield,
    Icons.work,
    Icons.star,
  ];

  // الألوان المتاحة للحسابات
  static const List<Color> accountColors = [
    Color(0xFFB83A2E), Color(0xFF2F5A3A), Color(0xFFD4A853), Color(0xFF6E5238),
    Color(0xFF3E6B8A), Color(0xFF8A4F7D), Color(0xFFC2703D), Color(0xFF4F8A7D),
  ];

  // مراحل التعليم
  static const Map<String, List<String>> stages = {
    'primary': ['أول ابتدائي', 'ثاني ابتدائي', 'ثالث ابتدائي', 'رابع ابتدائي', 'خامس ابتدائي', 'سادس ابتدائي'],
    'middle': ['أول متوسط', 'ثاني متوسط', 'ثالث متوسط'],
    'high': ['أول ثانوي', 'ثاني ثانوي', 'ثالث ثانوي']
  };
}
