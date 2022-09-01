import 'package:flutter/material.dart';

class AppConstants {
  static const String CONTACT_MAIL = "keanggotaan@keadilanrakyat.org";

  static const String PLAY_STORE_URL =
      "https://play.google.com/store/apps/details?id=org.keadilanrakyat.pkr";
  static const String APP_STORE_URL =
      "https://apps.apple.com/us/app/adil/id1609854829";

  static const bool IS_OFFLINE_FLOW = true;
}

class ColorConstants {
  static const Color PRIMARY = Color(0xFFFF0018);
  static const Color BACKGROUND = Color(0xFFFFF9F5);
  static const Color PRIMARY_DARK = Color(0xFF38BEFE);
  static const Color PRIMARY_LIGHT = Color(0xFF3ECAFF);
  static const Color PRIMARY_EXTRA_LIGHT = Color(0xFFE5F6FE);
  static const Color DISABLED_BUTTON = Color.fromARGB(255, 189, 189, 189);
  static const Color DISABLED_TAB = Color(0xFFD0CFD3);
  static const Color WARNING_BACKGROUND = Color(0xFFF9EDDC);
  static const Color TEXT_GREY = Color(0xFF646464);
  static const Color SPLASH_GRADIENT_START = Color(0xFFFD7121);
  static const Color SPLASH_GRADIENT_END = Color(0xFFF9D729);
  static const Color DRAWER_SELECTED = Color(0xFFFFF4F5);
  static const Color LIGHT_BLACK = Color(0xFF212121);
  static const Color SHADOW_COLOR = Color(0xFFFF0010);
  static const Color UNSELECTED_TAB_TEXT = Color(0xFF5C5C5C);
  static const Color GREEN_COLOR = Color(0xFF15AC48);
  static const Color BLUE_COLOR = Color(0xFF689DF6);
  static const Color DARK_BLUE_COLOR = Color(0xFF0085FF);

  static const Gradient PRIMARY_GRADIENT = LinearGradient(
    colors: [
      ColorConstants.SPLASH_GRADIENT_START,
      ColorConstants.SPLASH_GRADIENT_END,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static Color statusColor(String status) {
    switch (status) {
      case "Pending Payment":
      case "Pending Approval":
      case "Pending Acceptance":
      case "Pending Decision":
      case "Pending Review":
      case "Pending":
      case "UnSync":
        return Colors.orange;
      case "Accepted":
      case "Approved":
      case "Success":
      case "Submitted":
        return Colors.green;
      case "Rejected":
      case "Reject":
      case "Failed":
      case "Declined":
      case "Withdrawn":
      case "Objected":
      case "Appealed":
      case "Error":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class MapConstants {
  static const String MAP_STYLE =
      '[{"featureType":"water","elementType":"geometry","stylers":[{"color":"#e9e9e9"},{"lightness":17}]},{"featureType":"landscape","elementType":"geometry","stylers":[{"color":"#f5f5f5"},{"lightness":20}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#ffffff"},{"lightness":17}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#ffffff"},{"lightness":29},{"weight":0.2}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#ffffff"},{"lightness":18}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#ffffff"},{"lightness":16}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#f5f5f5"},{"lightness":21}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#dedede"},{"lightness":21}]},{"elementType":"labels.text.stroke","stylers":[{"visibility":"on"},{"color":"#ffffff"},{"lightness":16}]},{"elementType":"labels.text.fill","stylers":[{"saturation":36},{"color":"#333333"},{"lightness":40}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#f2f2f2"},{"lightness":19}]},{"featureType":"administrative","elementType":"geometry.fill","stylers":[{"color":"#fefefe"},{"lightness":20}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#fefefe"},{"lightness":17},{"weight":1.2}]}]';
}
