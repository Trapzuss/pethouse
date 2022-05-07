import 'package:flutter/material.dart';

class AppTheme {
  static final colors = AppColors();
  static final src = AppSrc();

  const AppTheme._();

  static ThemeData define() {
    return ThemeData(primaryColor: const Color(0xFFFED269));
  }
}

class AppColors {
  final primary = const Color(0xFFFED269);
  final primaryFontColor = const Color.fromARGB(255, 78, 78, 78);
  final secondaryFontColor = const Color(0xFF878787);
  final darkFontColor = const Color(0xFF263238);
}

class AppSrc {
  final profile =
      'https://scontent.fbkk5-5.fna.fbcdn.net/v/t1.6435-9/36651074_212461769474814_7168091260706619392_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeEKwhclmz1vfcO2mjZ-PHCBPxByT47k74g_EHJPjuTviK3gMHAcLO7aMtzrprP1fYHlS_yfLdhYWXJbZHdab85_&_nc_ohc=S0i37OE423wAX-919Ie&_nc_ht=scontent.fbkk5-5.fna&oh=00_AT-2kmB_MfZY3W7zzbWoLsJR77Db3gx0HBrcksxnSJbMGg&oe=62992A8A';
  final empty =
      'https://img.freepik.com/free-vector/cautious-dog-concept-illustration_114360-5228.jpg?w=740&t=st=1651687836~exp=1651688436~hmac=0d43f76081c7d3dda56fe2cbe3e90995625001dd1cd4474469dd8896aa327c3a';
}
