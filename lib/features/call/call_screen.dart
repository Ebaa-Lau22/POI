import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/localization/l10n/context_localiztion.dart';
import 'package:poi/core/theme/app_colors.dart';

import '../../core/app_cubit/app_states.dart';
import 'call_cubit.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "POI";
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
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
            if (state is CallConnectedState) {
              localVideo = state.localTrack;
              isConnected = true;
            } else if (state is CallRemoteTrackReceivedState) {
              remoteVideo = state.remoteTrack;
              isConnected = true;
            } else if (state is CallConnectingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CallErrorState) {
              return Center(child: Text('Error: ${state.message}'));
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
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 50.0,
                  horizontal: 50.0,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: color.red,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: color.primary,
                            child:
                                localVideo != null
                                    ? VideoTrackRenderer(localVideo)
                                    : Center(
                                      child: Text(context.loc.yourVideo,
                                      style: textStyle.bodyLarge
                                      ),
                                    ),
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
                                    ? VideoTrackRenderer(remoteVideo)
                                    : Center(
                                      child: Text(context.loc.waitingForRemoteVideo,
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
                                    url:
                                        'wss://flutterpoi-ar6hq9rt.livekit.cloud',
                                    token:
                                        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NDczOTg4NzksImlzcyI6IkFQSTlVNVJXbVpOM2UzOCIsIm5iZiI6MTc0NzM5Nzk3OSwic3ViIjoiQWtyYW0iLCJ2aWRlbyI6eyJjYW5QdWJsaXNoIjp0cnVlLCJjYW5QdWJsaXNoRGF0YSI6dHJ1ZSwiY2FuU3Vic2NyaWJlIjp0cnVlLCJyb29tIjoiVmlldyIsInJvb21Kb2luIjp0cnVlfX0.ltg3ohDUdMbvv09SnOQQaCOhkjhYrffzUbPo9FI2xgE',
                                  );
                                },
                        child: Text(context.loc.startCall),
                      ),
                    ),
                  ],
                ),
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
//! token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NDczOTg4NzksImlzcyI6IkFQSTlVNVJXbVpOM2UzOCIsIm5iZiI6MTc0NzM5Nzk3OSwic3ViIjoiQWtyYW0iLCJ2aWRlbyI6eyJjYW5QdWJsaXNoIjp0cnVlLCJjYW5QdWJsaXNoRGF0YSI6dHJ1ZSwiY2FuU3Vic2NyaWJlIjp0cnVlLCJyb29tIjoiVmlldyIsInJvb21Kb2luIjp0cnVlfX0.ltg3ohDUdMbvv09SnOQQaCOhkjhYrffzUbPo9FI2xgE
// url: wss://flutterpoi-ar6hq9rt.livekit.cloud
