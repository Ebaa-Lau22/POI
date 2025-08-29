// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:poi/core/app_cubit/app_cubit.dart';
// import 'package:poi/core/app_cubit/app_states.dart';
// import 'package:poi/core/components/navigators.dart';
// import 'package:poi/core/constants/appImgaeAsset.dart';
// import 'package:poi/core/constants/constants.dart';
// import 'package:poi/core/localization/l10n/context_localiztion.dart';
// import 'package:poi/core/storage/preferences_database.dart';
// import 'package:poi/core/theme/app_colors.dart';
// import 'package:poi/features/Authentication/domain/entities/auth.dart';
// import 'package:poi/features/Authentication/presentation/bloc/auth_cubit.dart';
// import 'package:poi/features/Authentication/presentation/bloc/auth_states.dart';
// import 'package:poi/features/call/call_screen.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool _obscurePassword = true;

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         final appCubit = context.read<AppCubit>();
//         final color = ThemedColors(appCubit.isLightTheme);
//         final textStyle = Theme.of(context).textTheme;
//         final mediaQuery = MediaQuery.of(context);
//         final screenHeight = mediaQuery.size.height;
//         final screenWidth = mediaQuery.size.width;

//         return Scaffold(
//           backgroundColor: color.primary,
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: screenWidth * 0.05,
//                 vertical: screenHeight * 0.03,
//               ),
//               child: Form(
//                 key: _formKey,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 child: Column(
//                   children: [
//                     SizedBox(height: screenHeight * 0.12),
//                     SvgPicture.asset(
//                       AppImageAsset.WelcomeImage,
//                       width: screenWidth * 0.55,
//                       height: screenHeight * 0.25,
//                     ),
//                     SizedBox(height: screenHeight * 0.02),
//                     Text(
//                       context.loc.welcome,
//                       textAlign: TextAlign.center,
//                       style: textStyle.displayMedium,
//                     ),
//                     SizedBox(height: screenHeight * 0.05),

//                     // Email
//                     TextFormField(
//                       controller: emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         border: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(12)),
//                         ),
//                         labelText: context.loc.email,
//                         labelStyle: textStyle.bodyLarge,
//                       ),
//                       cursorWidth: 2,
//                       cursorHeight: 20,
//                       cursorRadius: const Radius.circular(8),
//                       validator: (value) {
//                         final emailRegex = EmailRegExp;
//                         return value == null || !emailRegex.hasMatch(value)
//                             ? context.loc.enterValidEmail
//                             : null;
//                       },
//                     ),
//                     SizedBox(height: screenHeight * 0.02),

//                     // Password
//                     TextFormField(
//                       controller: passwordController,
//                       obscureText: _obscurePassword,
//                       decoration: InputDecoration(
//                         border: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(12)),
//                         ),
//                         labelText: context.loc.password,
//                         labelStyle: textStyle.bodyLarge,
//                         suffixIcon: Padding(
//                           padding: EdgeInsets.only(right: screenWidth * 0.02),
//                           child: IconButton(
//                             iconSize: screenWidth * 0.045,
//                             icon: Icon(
//                               _obscurePassword
//                                   ? Icons.visibility_off_rounded
//                                   : Icons.visibility_rounded,
//                               color: color.secondary,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _obscurePassword = !_obscurePassword;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       cursorWidth: 2,
//                       cursorHeight: 20,
//                       cursorRadius: const Radius.circular(8),
//                       validator: (value) {
//                         final passwordRegex = PasswordRegExp;
//                         if (value == null || !passwordRegex.hasMatch(value)) {
//                           return context.loc.passwordValidationMessage;
//                         }
//                         return null;
//                       },
//                     ),

//                     SizedBox(height: screenHeight * 0.01),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {
//                           context.go('/forgetPassword');
//                         },
//                         child: Text(
//                           context.loc.forgetPassword,
//                           style: textStyle.bodyLarge,
//                         ),
//                       ),
//                     ),

//                     SizedBox(height: screenHeight * 0.04),
//                     BlocConsumer<AuthCubit, AuthStates>(
//                       listener: (context, state) {
//                         if (state is AuthLoginSuccessState) {
//                           final token = state.response.data?.token;
//                           final guard = state.response.data?.guard;
//                           final message =
//                               state.response.message ?? "Login successful";

//                           ScaffoldMessenger.of(
//                             context,
//                           ).showSnackBar(SnackBar(content: Text(message)));

//                           final prefs = PreferencesDatabase();

//                           if (token != null) {
//                             prefs.setToken(token);
//                           }

//                           if (guard != null) {
//                             prefs.setEncryptedValue("Guard", guard);
//                           }

//                           print("[Login] Token: ${prefs.getToken()}");
//                           print(
//                             "[Login] Guard: ${prefs.getEncryptedValue("Guard")}",
//                           );
//                           emailController.clear();
//                           passwordController.clear();
//                           navigateAndFinish(context, VideoCallScreen());
//                         }
//                         if (state is AuthLoginErrorState) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text(state.errorMessage)),
//                           );
//                         }
//                       },
//                       builder: (context, state) {
//                         final cubit = context.read<AuthCubit>();
//                         return state is AuthLoadingState
//                             ? Center(
//                               child: LoadingAnimationWidget.discreteCircle(
//                                 color: color.blue,
//                                 secondRingColor: color.red,
//                                 thirdRingColor: color.primary,
//                                 size: 28,
//                               ),
//                             )
//                             : SizedBox(
//                               width: screenWidth * 0.40,
//                               height: screenHeight * 0.06,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: color.secondary,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   if (_formKey.currentState!.validate()) {
//                                     print("Email: ${emailController.text}");
//                                     print(
//                                       "Password: ${passwordController.text}",
//                                     );
//                                     cubit.login(
//                                       login_entity: LoginEntity(
//                                         email: emailController.text,
//                                         password: passwordController.text,
//                                       ),
//                                     );
//                                   }
//                                 },
//                                 child: Text(
//                                   context.loc.signin,
//                                   style: textStyle.bodyLarge?.copyWith(
//                                     color: color.primary,
//                                   ),
//                                 ),
//                               ),
//                             );
//                       },
//                     ),
//                     SizedBox(height: screenHeight * 0.03),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/core/components/navigators.dart';
import 'package:poi/core/constants/appImgaeAsset.dart';
import 'package:poi/core/constants/constants.dart';
import 'package:poi/core/localization/l10n/context_localiztion.dart';
import 'package:poi/core/storage/preferences_database.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/features/Authentication/domain/entities/auth.dart';
import 'package:poi/features/Authentication/presentation/bloc/auth_cubit.dart';
import 'package:poi/features/Authentication/presentation/bloc/auth_states.dart';
import 'package:poi/features/Debates/presentation/pages/debates_page.dart';
import 'package:poi/features/call/call_screen.dart';
import 'package:poi/features/profiles/profile_page.dart';
import 'package:poi/home_page.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final appCubit = context.read<AppCubit>();
        final color = ThemedColors(appCubit.isLightTheme);
        final textStyle = Theme.of(context).textTheme;

        return Scaffold(
          backgroundColor: color.primary,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    SvgPicture.asset(
                      AppImageAsset.WelcomeImage,
                      width: 55.w,
                      height: 25.h,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      context.loc.welcome,
                      textAlign: TextAlign.center,
                      style: textStyle.displayMedium?.copyWith(
                        color: color.secondary,
                      ),
                    ),
                    SizedBox(height: 5.h),

                    // Email
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        labelText: context.loc.email,
                        labelStyle: textStyle.bodyLarge,
                      ),
                      cursorWidth: 2,
                      cursorHeight: 20,
                      cursorRadius: const Radius.circular(8),
                      validator: (value) {
                        final emailRegex = EmailRegExp;
                        return value == null || !emailRegex.hasMatch(value)
                            ? context.loc.enterValidEmail
                            : null;
                      },
                    ),
                    SizedBox(height: 2.h),

                    // Password
                    TextFormField(
                      controller: passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        labelText: context.loc.password,
                        labelStyle: textStyle.bodyLarge,
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: IconButton(
                            iconSize: 4.5.w,
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: color.secondary,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      cursorWidth: 2,
                      cursorHeight: 20,
                      cursorRadius: const Radius.circular(8),
                      validator: (value) {
                        final passwordRegex = PasswordRegExp;
                        if (value == null || !passwordRegex.hasMatch(value)) {
                          return context.loc.passwordValidationMessage;
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 1.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          context.go('/forgetPassword');
                        },
                        child: Text(
                          context.loc.forgetPassword,
                          style: textStyle.bodyLarge,
                        ),
                      ),
                    ),

                    SizedBox(height: 4.h),
                    BlocConsumer<AuthCubit, AuthStates>(
                      listener: (context, state) async {
                        if (state is AuthLoginSuccessState) {
                          final token = state.response.data?.token;
                          final guard = state.response.data?.guard;
                          final message = state.response.message;

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(message)));

                          final prefs = PreferencesDatabase();

                          if (token != null) {
                            await prefs.setToken(token);
                          }

                          if (guard != null) {
                            await prefs.setEncryptedValue("Guard", guard);
                          }

                          final savedToken = await prefs.getToken();
                          final savedGuard = await prefs.getEncryptedValue(
                            "Guard",
                          );

                          print("Token: $savedToken , guard: $savedGuard");

                          navigateAndFinish(context, HomePage());
                        }
                        if (state is AuthLoginErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)),
                          );
                        }
                      },
                      builder: (context, state) {
                        final cubit = context.read<AuthCubit>();
                        return state is AuthLoadingState
                            ? Center(
                              child: LoadingAnimationWidget.discreteCircle(
                                color: color.blue,
                                secondRingColor: color.red,
                                thirdRingColor: color.primary,
                                size: 28,
                              ),
                            )
                            : SizedBox(
                              width: 40.w,
                              height: 6.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: color.secondary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.login(
                                      login_entity: LoginEntity(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  context.loc.signin,
                                  style: textStyle.bodyLarge?.copyWith(
                                    color: color.primary,
                                  ),
                                ),
                              ),
                            );
                      },
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
