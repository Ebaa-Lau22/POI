// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:poi/core/app_cubit/app_cubit.dart';
// import 'package:poi/core/app_cubit/app_states.dart';
// import 'package:poi/core/constants/appImgaeAsset.dart';
// import 'package:poi/core/constants/constants.dart';
// import 'package:poi/core/localization/l10n/context_localiztion.dart';
// import 'package:poi/core/storage/preferences_database.dart';
// import 'package:poi/core/theme/app_colors.dart';
// import 'package:poi/core/theme/font_styles.dart';
// import 'package:poi/features/Authentication/domain/entities/auth.dart';
// import 'package:poi/features/Authentication/presentation/bloc/auth_cubit.dart';
// import 'package:poi/features/Authentication/presentation/bloc/auth_states.dart';
// import 'package:poi/features/posts/presentation/widgets/message_display_widget.dart';
// import 'package:poi/routing/app_route.dart';

// class ForgetPasswordPage extends StatefulWidget {
//   const ForgetPasswordPage({super.key});

//   @override
//   State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
// }

// class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();

//   // void _submit() {
//   //   if (_formKey.currentState!.validate()) {
//   //     final email = _emailController.text.trim();
//   //     // ScaffoldMessenger.of(
//   //     //   context,
//   //     // ).showSnackBar(SnackBar(content: Text('Reset link sent to $email')));
//   //   }
//   // }

//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return context.loc.enterValidEmail;
//     }
//     if (!EmailRegExp.hasMatch(value)) {
//       return context.loc.enterValidEmail;
//     }
//     return null;
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final screenHeight = constraints.maxHeight;
//         final screenWidth = constraints.maxWidth;
//         return BlocConsumer<AppCubit, AppStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             final appCubit = context.read<AppCubit>();
//             final color = ThemedColors(appCubit.isLightTheme);
//             final textStyle = Theme.of(context).textTheme;
//             return BlocConsumer<AuthCubit, AuthStates>(
//               listener: (context, state) async {
//                 if (state is AuthSendCodeSuccessState) {
//                   final prefs = PreferencesDatabase();
//                   await prefs.setEncryptedValue(
//                     'USER_EMAIL',
//                     _emailController.text,
//                   );
//                   ScaffoldMessenger.of(
//                     context,
//                   ).showSnackBar(SnackBar(content: Text(state.successMessage)));
//                   context.go(AppRoute.sentVerificationCode);
//                 }
//                 if (state is AuthSendCodeErrorState) {
//                   ScaffoldMessenger.of(
//                     context,
//                   ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
//                 }
//               },
//               builder: (context, state) {
//                 final cubit = context.read<AuthCubit>();
//                 return Scaffold(
//                   backgroundColor: Color.fromRGBO(225, 230, 242, 1),
//                   appBar: AppBar(
//                     leading: IconButton(
//                       onPressed: () {
//                         context.go(AppRoute.loginPageRoute);
//                       },
//                       icon: Icon(
//                         Icons.arrow_back_ios_new_rounded,
//                         size: screenWidth * 0.05,
//                         color: AppColors.darkBlue,
//                       ),
//                     ),
//                     backgroundColor: Color.fromRGBO(225, 230, 242, 1),
//                   ),
//                   body: SingleChildScrollView(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: screenWidth * 0.06,
//                       ),
//                       child: Form(
//                         key: _formKey,
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         child: Column(
//                           children: [
//                             SizedBox(height: screenHeight * 0.04),
//                             SvgPicture.asset(
//                               AppImageAsset.forgetPasswordImage,
//                               width: screenWidth * 0.6,
//                               height: screenHeight * 0.25,
//                             ),
//                             SizedBox(height: screenHeight * 0.02),
//                             Text(
//                               context.loc.forgetYourPassword,
//                               style: textForgetPasswordTitle.copyWith(
//                                 fontSize: screenWidth * 0.055,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             SizedBox(height: screenHeight * 0.02),
//                             Text(
//                               context.loc.enterEmailToGetCode,
//                               textAlign: TextAlign.start,
//                               style: textIntro.copyWith(
//                                 fontSize: screenWidth * 0.042,
//                               ),
//                             ),
//                             SizedBox(height: screenHeight * 0.04),
//                             //Email
//                             TextFormField(
//                               controller: _emailController,
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(12),
//                                   ),
//                                 ),
//                                 labelText: context.loc.yourEmail,
//                                 labelStyle: labeltextformfield.copyWith(
//                                   fontSize: screenWidth * 0.042,
//                                 ),
//                               ),
//                               cursorWidth: 2,
//                               cursorHeight: 20,
//                               cursorRadius: Radius.circular(8),
//                               keyboardType: TextInputType.emailAddress,
//                               validator: _validateEmail,
//                             ),
//                             SizedBox(height: screenHeight * 0.05),

//                             SizedBox(
//                               width: screenWidth * 0.65,
//                               height: screenHeight * 0.06,
//                               child:
//                                   state is AuthLoadingState
//                                       ? Center(
//                                         child:
//                                             LoadingAnimationWidget.discreteCircle(
//                                               color: color.primary,
//                                               secondRingColor: color.secondary,
//                                               thirdRingColor: color.red,
//                                               size: screenWidth * 0.08,
//                                             ),
//                                       )
//                                       : ElevatedButton(
//                                         onPressed: () {
//                                           if (_formKey.currentState!
//                                               .validate()) {
//                                             cubit.sendCode(
//                                               sendCodeEntity: SendCodeEntity(
//                                                 email: _emailController.text,
//                                               ),
//                                             );
//                                           }
//                                         },
//                                         child: Text(
//                                           context.loc.sendResetCode,
//                                           style: textButton.copyWith(
//                                             fontSize: screenWidth * 0.045,
//                                           ),
//                                         ),
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: AppColors.darkBlue,
//                                           // shape: RoundedRectangleBorder(
//                                           //     borderRadius: BorderRadius.circular(12),
//                                           //   ),
//                                         ),
//                                       ),
//                             ),

//                             SizedBox(height: screenHeight * 0.03),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }
