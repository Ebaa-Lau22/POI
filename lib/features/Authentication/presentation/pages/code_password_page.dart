// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:poi/core/constants/appImgaeAsset.dart';
// import 'package:poi/core/localization/l10n/context_localiztion.dart';
// import 'package:poi/core/theme/app_colors.dart';
// import 'package:poi/core/theme/font_styles.dart';
// import 'package:poi/routing/app_route.dart';

// class CodePasswordPage extends StatefulWidget {
//   const CodePasswordPage({super.key});

//   @override
//   State<CodePasswordPage> createState() => _CodePasswordPageState();
// }

// class _CodePasswordPageState extends State<CodePasswordPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _codeController = TextEditingController();
//   //String? email = await PreferencesDatabase().getEncryptedValue<String>('USER_EMAIL');

//   @override
//   void dispose() {
//     _codeController.dispose();
//     super.dispose();
//   }

//   String? _validateCode(String? value) {
//     if (value == null || value.isEmpty) {
//       return context.loc.enterCodeValidation;
//     }
//     if (value.length != 6) {
//       return context.loc.codeValidation;
//     }
//     return null;
//   }

//   // void _submit() {
//   //   if (_formKey.currentState!.validate()) {
//   //     context.go(AppRoute.resetPassword);
//   //   }
//   // }

//   void _resendCode() {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(context.loc.codeResent)));
//     //
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainLight,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             context.go(AppRoute.forgetPassword);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_new_rounded,
//             size: 18,
//             color: AppColors.darkBlue,
//           ),
//         ),
//         backgroundColor: AppColors.darkBlue,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               SizedBox(height: 40),
//               SvgPicture.asset(
//                 AppImageAsset.forgetPasswordImage,
//                 width: 250,
//                 height: 250,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 context.loc.enterCode,
//                 style: textTitle,
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 30),
//               Text(
//                 context.loc.enterCodeDescripe,
//                 textAlign: TextAlign.start,
//                 style: textIntro,
//               ),
//               const SizedBox(height: 32),
//               TextFormField(
//                 controller: _codeController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12)),
//                   ),
//                   labelText: context.loc.verificationCode,
//                   labelStyle: labeltextformfield,
//                 ),
//                 cursorWidth: 2,
//                 cursorHeight: 20,
//                 cursorRadius: Radius.circular(8),
//                 keyboardType: TextInputType.number,
//                 maxLength: 6,
//                 validator: _validateCode,
//               ),
//               const SizedBox(height: 35),
//               ElevatedButton(
//                 onPressed: () {
//                   context.go(AppRoute.resetPassword);
//                 },
//                 //_submit,
//                 child: Text(context.loc.confirmCode, style: textButton),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.darkBlue,
//                 ),
//               ),
//               const SizedBox(height: 5),
//               TextButton(
//                 onPressed: _resendCode,
//                 child: Text(context.loc.notRecieveCode, style: textResentCode),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
