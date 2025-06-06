import 'dart:io' as Thread;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/components/navigators.dart';
import 'package:poi/core/localization/l10n/context_localiztion.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/features/call/connection_cubit.dart';
import 'package:poi/features/call/connection_states.dart';
import 'package:poi/features/call/no_connection_screen.dart';

import '../../core/app_cubit/app_states.dart';
import '../../core/components/connection_quality_indicator.dart';
import '../../core/components/custom_toggle_button.dart';
import 'call_cubit.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "POI";
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        final url = "https://e6dd-93-190-138-199.ngrok-free.app";
        final token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJJYmFhIiwianRpIjoiSWJhYSIsImV4cCI6MTc0OTA3MDAzMCwibmJmIjoxNzQ5MDU1NjMwLCJpYXQiOjE3NDkwNTU2MzAsImlzcyI6ImRldmtleSIsInZpZGVvIjp7InJvb21Kb2luIjp0cnVlLCJyb29tIjoidGhlcm9vbSJ9fQ.SxIZ2QYCIRi4oD_WrYy3RtJRhYmXIX34-5YgjBFILvE";
        final appCubit = context.read<AppCubit>();
        final color = ThemedColors(appCubit.isLightTheme);
        final textStyle = Theme.of(context).textTheme;
        return BlocConsumer<CallCubit, CallStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = context.read<CallCubit>();
            LocalVideoTrack? localVideo;
            RemoteVideoTrack? remoteVideo;
            bool isConnected = false;
            if (state is CallLocalTrackUpdatedState) {
              localVideo = state.localTrack;
              isConnected = true;
            } else if (state is CallRemoteTrackReceivedState) {
              remoteVideo = state.remoteTrack;
              isConnected = true;
            } else if (state is CallConnectingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CallErrorState) {
              /*navigateAndFinish(
                context,
                NoConnectionScreen(
                  reason: state.message,
                  onRetry:
                      () => cubit.connectToRoom(
                        url: 'wss://flutterpoi-ar6hq9rt.livekit.cloud',
                        token: token,
                      ),
                ),
              );*/
              //showDialog(context: context, builder: ()=> LostC)
            }

            return Scaffold(
              appBar: AppBar(
                title: Text(title),
                actions: [
                  IconButton(
                    onPressed: () {
                      appCubit.changeTheme(!appCubit.isLightTheme);
                    },
                    icon: Icon(
                      appCubit.isLightTheme
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      appCubit.changeLocale(
                        appCubit.locale == "en" ? "ar" : "en",
                      );
                    },
                    icon: Icon(Icons.translate),
                  ),
                ],
              ),
              body: Column(
                children: [
                  BlocBuilder<ConnectionCubit, ConnectionStates>(
                    builder: (context, state) {
                      cubit.updateConnectionQuality();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ConnectionQualityIndicator(
                            quality: context.read<ConnectionCubit>().getConnectionQuality(cubit.connectionQuality),
                          ),
                          SizedBox(width: 10),
                        ],
                      );
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60.0,
                        vertical: 40.0,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              color: color.red,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Container(
                                      color: color.primary,
                                      child:
                                          localVideo != null &&
                                                  cubit.isCameraEnabled
                                              ? VideoTrackRenderer(localVideo, fit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,)
                                              : Center(
                                                child: Text(
                                                  context.loc.yourVideo,
                                                  style: textStyle.bodyLarge,
                                                ),
                                              ),
                                    ),
                                    if (!cubit.isMicEnabled)
                                      Padding(
                                        padding: const EdgeInsets.all(11.0),
                                        child: Material(
                                          shape: const CircleBorder(),
                                          color: color.secondary.withOpacity(
                                            0.35,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.5),
                                            child: Icon(
                                              Icons.mic_off_outlined,
                                              color: AppColors.lightRed,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Expanded(
                            child: Container(
                              color: color.blue,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: color.primary,
                                  child:
                                      remoteVideo != null
                                          ? VideoTrackRenderer(
                                        remoteVideo,
                                        fit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                                      )
                                          : Center(
                                            child: Text(
                                              context.loc.waitingForRemoteVideo,
                                              style: textStyle.bodyLarge,
                                            ),
                                          ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: ElevatedButton(
                              onPressed:
                                  isConnected
                                      ? null
                                      : () {
                                        cubit.connectToRoom(
                                          url: url,
                                          token: token,
                                        );
                                      },
                              child: Text(context.loc.startCall),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ToggleCircleButton(
                                isEnabled: cubit.isMicEnabled,
                                enabledIcon: Icons.mic_outlined,
                                disabledIcon: Icons.mic_off_outlined,
                                isLightTheme: appCubit.isLightTheme,
                                onPressed: () => cubit.toggleMic(),
                              ),
                              const SizedBox(width: 12),
                              ToggleCircleButton(
                                isEnabled: cubit.isCameraEnabled,
                                enabledIcon: Icons.videocam_outlined,
                                disabledIcon: Icons.videocam_off_outlined,
                                isLightTheme: appCubit.isLightTheme,
                                onPressed: () => cubit.toggleCamera(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// API secret: BVRgH7zHOl9J53zhUu9Af4ws8XKS7PnIfyBPxK9R0Cq
// API key: API9U5RWmZN3e38
//! token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NDg1Mjc2OTcsImlzcyI6IkFQSTlVNVJXbVpOM2UzOCIsIm5iZiI6MTc0ODUyNjc5Nywic3ViIjoiYWIiLCJ2aWRlbyI6eyJjYW5QdWJsaXNoIjp0cnVlLCJjYW5QdWJsaXNoRGF0YSI6dHJ1ZSwiY2FuU3Vic2NyaWJlIjp0cnVlLCJyb29tIjoiZGViYXRlIiwicm9vbUpvaW4iOnRydWV9fQ.6c65-J8uAAWan9t5NJmiTOHBvlhx45B2zNkOK9-kI9A
// url: wss://flutterpoi-ar6hq9rt.livekit.cloud
