import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/permission_cubit.dart';
import 'package:poi/permission_dialog.dart';

import 'features/call/call_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PermissionCubit>().checkAndRequestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PermissionCubit, PermissionState>(
        listener: (context, state) {
          if (state.granted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const VideoCallScreen()),
              );
            });
          } else if (state.deniedPermanently) {
            showPermissionDeniedDialog(context);
          }
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
