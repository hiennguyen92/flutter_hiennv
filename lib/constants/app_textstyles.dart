import 'package:flutter/material.dart';

//Regular
TextStyle regularTextStyle(
        {double? fontSize,
        String? fontFamily,
        Color? color,
        double? height,
        Color? backgroundColor}) =>
    TextStyle(
        fontFamily: fontFamily ?? null,
        fontWeight: FontWeight.w300,
        fontSize: fontSize ?? 14.0,
        color: color ?? null,
        backgroundColor: backgroundColor ?? null,
        height: height ?? null);

//Medium
TextStyle mediumTextStyle(
        {double? fontSize,
        String? fontFamily,
        Color? color,
        double? height,
        Color? backgroundColor}) =>
    TextStyle(
        fontFamily: fontFamily ?? null,
        fontSize: fontSize ?? 14.0,
        fontWeight: FontWeight.w500,
        color: color ?? null,
        backgroundColor: backgroundColor ?? null,
        height: height ?? null);

//Bold
TextStyle boldTextStyle(
        {double? fontSize,
        String? fontFamily,
        Color? color,
        double? height,
        Color? backgroundColor}) =>
    TextStyle(
        fontFamily: fontFamily ?? null,
        fontSize: fontSize ?? 14.0,
        fontWeight: FontWeight.w700,
        color: color ?? null,
        backgroundColor: backgroundColor ?? null,
        height: height ?? null);
