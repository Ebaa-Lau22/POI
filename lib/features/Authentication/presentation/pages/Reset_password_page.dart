// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:poi/core/constants/appImgaeAsset.dart';
// import 'package:poi/core/localization/l10n/context_localiztion.dart';
// import 'package:poi/core/theme/app_colors.dart';
// import 'package:poi/core/theme/font_styles.dart';
// import 'package:poi/routing/app_route.dart';

// class ResetPasswordPage extends StatefulWidget {
//   @override
//   _ResetPasswordPageState createState() => _ResetPasswordPageState();
// }

// class _ResetPasswordPageState extends State<ResetPasswordPage> {
//   final _formKey = GlobalKey<FormState>();
//   final newPasswordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   bool _obscureNewPassword = true;
//   bool _obscureConfirmPassword = true;

//   @override
//   void dispose() {
//     newPasswordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   // void _submit() {
//   //   if (_formKey.currentState!.validate()) {
//   //     ScaffoldMessenger.of(
//   //       context,
//   //     ).showSnackBar(SnackBar(content: Text('Password reset successfully')));
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainLight,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             context.go(AppRoute.sentVerificationCode);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios_new_rounded,
//             size: 18,
//             color: AppColors.darkBlue,
//           ),
//         ),
//         backgroundColor: AppColors.darkBlue,
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               SizedBox(height: 30),
//               SvgPicture.asset(
//                 AppImageAsset.resetPasswordImage,
//                 width: 250,
//                 height: 250,
//               ),
//               SizedBox(height: 10),
//               Text(
//                 context.loc.resetPassword,
//                 style: textTitle,
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 30),

//               // New Password
//               TextFormField(
//                 controller: newPasswordController,
//                 obscureText: _obscureNewPassword,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12)),
//                   ),
//                   labelText: context.loc.password,
//                   labelStyle: labeltextformfield,
//                   suffixIcon: Padding(
//                     padding: const EdgeInsets.only(right: 10),
//                     child: IconButton(
//                       iconSize: 18,
//                       icon: Icon(
//                         _obscureNewPassword
//                             ? Icons.visibility_off_rounded
//                             : Icons.visibility_rounded,
//                         color: AppColors.darkBlue,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscureNewPassword = !_obscureNewPassword;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 cursorWidth: 2,
//                 cursorHeight: 20,
//                 cursorRadius: Radius.circular(8),

//                 validator: (value) {
//                   if (value == null || value.length < 6) {
//                     return context.loc.passwordValidationMessage;
//                   }
//                   return null;
//                 },
//               ),

//               SizedBox(height: 16),

//               // Confirm Password
//               TextFormField(
//                 controller: confirmPasswordController,
//                 obscureText: _obscureConfirmPassword,
//                 decoration: InputDecoration(
//                   labelText: context.loc.confirmPassword,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12)),
//                   ),

//                   labelStyle: labeltextformfield,
//                   suffixIcon: Padding(
//                     padding: const EdgeInsets.only(right: 10),
//                     child: IconButton(
//                       iconSize: 18,
//                       icon: Icon(
//                         _obscureConfirmPassword
//                             ? Icons.visibility_off_rounded
//                             : Icons.visibility_rounded,
//                         color: AppColors.darkBlue,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscureConfirmPassword = !_obscureConfirmPassword;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 cursorWidth: 2,
//                 cursorHeight: 20,
//                 cursorRadius: Radius.circular(8),
//                 validator: (value) {
//                   if (value != newPasswordController.text) {
//                     return context.loc.passNotMatch;
//                   }
//                   return null;
//                 },
//               ),

//               SizedBox(height: 40),

//               SizedBox(
//                 width: 180,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // context.go('/forget_password');
//                   },
//                   //_submit,
//                   child: Text(context.loc.updatePassword, style: textButton),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.darkBlue,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
