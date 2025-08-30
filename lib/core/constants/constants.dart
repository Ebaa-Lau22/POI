import 'package:flutter/material.dart';

// const String SERVER_FAILURE_MESSAGE = 'Please try again later .';
// const String EMPTY_CACHE_FAILURE_MESSAGE = 'No Data';
// const String OFFLINE_FAILURE_MESSAGE = 'Please Check your Internet Connection';
// const String UNEXPECTED_FAILURE_MESSAGE = 'UNEXPECTED_FAILURE_MESSAGE';
const String SERVER_FAILURE_MESSAGE = 'يرجى المحاولة لاحقاً مرة أخرى';
const String EMPTY_CACHE_FAILURE_MESSAGE = 'لا توجد بيانات';
const String OFFLINE_FAILURE_MESSAGE = 'يرجى التحقق من اتصالك بالإنترنت';
const String UNEXPECTED_FAILURE_MESSAGE = 'خطأ غير متوقع';
const String BANNED_FAILURE_MESSAGE = 'أنت محظور من التطبيق';
const String incorrect_Data_Failure_Message =
    'The provided information is not correct.Please try again.';
const String ADD_POST_SUCCESS_MESSAGE = 'Post added successfully';
const String Update_POST_SUCCESS_MESSAGE = 'Post updated successfully';
const String Delete_POST_SUCCESS_MESSAGE = 'Post deleted successfully';
const String LOGIN_SUCCESS_MESSAGE = 'Login successful';
const String SEND_CODE_SUCCESS_MESSAGE = 'Verification code sent successfully';
const String VERIFY_CODE_SUCCESS_MESSAGE = 'Code verified successfully';
const String RESET_PASSWORD_SUCCESS_MESSAGE = 'Password reset successfully';

RegExp EmailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');

RegExp PasswordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
const double widgetBorderRadius = 20;

Locale get englishLocale => const Locale('en');

Locale get arabicLocale => const Locale('ar');

const String poiBaseUrl = "http://31.97.46.191/api/";
