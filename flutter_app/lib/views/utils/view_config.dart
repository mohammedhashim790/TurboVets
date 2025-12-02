import 'package:flutter/material.dart';

const kBackgroundColor = Colors.black;
const kNavigationLabelColor = Colors.white;
const kWhiteTextColor = Color(0xffFFFFFF);
const kB8B8TextColor = Color(0xffB8B8B8);
Color kB8B8TextColorwithOpacity = const Color(
  0xffBABABA,
).withValues(alpha: 0.8);
Color kGrey100TextColorWithOpacity = Colors.grey.shade500.withValues(
  alpha: 0.5,
);

double kTextLarge(BuildContext context) => 21.0;
double kTextSmall(BuildContext context) => 11.0;
double kTextMedium(BuildContext context) => 16.0;

TextStyle kTextStyle(BuildContext context) =>
    TextStyle(fontFamily: 'Urbanist', fontSize: kTextMedium(context));

TextStyle kHeaderTextStyle(BuildContext context) =>
    TextStyle(fontFamily: 'Urbanist', fontSize: kTextLarge(context));
