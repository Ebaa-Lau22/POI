import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/core/constants/appImgaeAsset.dart';
import 'package:poi/core/constants/constants.dart';
import 'package:poi/core/localization/l10n/context_localiztion.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/core/theme/font_styles.dart';
import 'package:poi/features/Authentication/domain/entities/auth.dart';
import 'package:poi/features/Authentication/presentation/bloc/auth_cubit.dart';
import 'package:poi/features/Authentication/presentation/bloc/auth_states.dart';
import 'package:poi/features/posts/presentation/widgets/message_display_widget.dart';

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
          final mediaQuery = MediaQuery.of(context);
          final screenHeight = mediaQuery.size.height;
          final screenWidth = mediaQuery.size.width;

          return BlocBuilder<AuthCubit, AuthStates>(
            builder: (context, state){
              final cubit = context.read<AuthCubit>();
              return Scaffold(
                backgroundColor: const Color.fromRGBO(225, 230, 242, 1),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.03,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight * 0.12),
                          SvgPicture.asset(
                            AppImageAsset.WelcomeImage,
                            width: screenWidth * 0.55,
                            height: screenHeight * 0.25,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            context.loc.welcome,
                            textAlign: TextAlign.center,
                            style: textloginpage,
                          ),
                          SizedBox(height: screenHeight * 0.05),

// Email
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              labelText: context.loc.email,
                              labelStyle: labeltextformfield,
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
                          SizedBox(height: screenHeight * 0.02),

// Password
                          TextFormField(
                            controller: passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              labelText: context.loc.welcome,
                              labelStyle: labeltextformfield,
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: screenWidth * 0.02),
                                child: IconButton(
                                  iconSize: screenWidth * 0.045,
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility_rounded,
                                    color: AppColors.mainDark,
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
                              final passwordRegex = RegExp(
                                r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
                              );
                              if (value == null || !passwordRegex.hasMatch(value)) {
                                return context.loc.passwordValidationMessage;
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: screenHeight * 0.01),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                context.go('/forget_password');
                              },
                              child: Text(
                                context.loc.forgetPassword,
                                style: labeltextformfield,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          SizedBox(
                            width: screenWidth * 0.40,
                            height: screenHeight * 0.06,
                            child: BlocConsumer<AuthCubit, AuthStates>(
                              listener: (context, state) {
                                if (state is AuthLoginSuccessState) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.successMessage)),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is AuthLoginLoadingState) {
                                  return Center(
                                    child: LoadingAnimationWidget.discreteCircle(
                                      color: color.primary,
                                      secondRingColor: color.secondary,
                                      thirdRingColor: color.red,
                                      size: screenWidth * 0.045,
                                    ),
                                  );
                                } else if (state is AuthLoginErrorState) {
                                  return MessageDisplayWidget(
                                    message: state.errorMessage,
                                  );
                                }
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.mainDark,
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
                                  child: Text(context.loc.signin, style: textButton),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          );
        }
    );
  }
}
