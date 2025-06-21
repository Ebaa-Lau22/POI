import 'dart:async';
import 'dart:io' as Thread;

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/components/loading_widget.dart';
import 'package:poi/core/components/navigators.dart';
import 'package:poi/core/constants/constants.dart';
import 'package:poi/core/localization/l10n/context_localiztion.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/features/call/connection_cubit.dart';
import 'package:poi/features/call/connection_states.dart';
import 'package:poi/features/call/no_connection_screen.dart';
import 'package:poi/features/call/widgets/custom_mute_indicator.dart';
import 'package:poi/features/call/widgets/custom_speaking_indicator.dart';
import 'package:poi/features/call/widgets/no_animation_scroll.dart';
import 'package:poi/features/call/widgets/video_cards.dart';

import '../../core/app_cubit/app_states.dart';
import '../../core/components/connection_quality_indicator.dart';
import '../../core/components/custom_toggle_button.dart';
import '../../widgets/sound_waveform.dart';
import 'call_cubit.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key});
  @override
  Widget build(BuildContext context) {
    String title = "POI";
    final PageController _controller = PageController();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final bool isTablet = width>450;
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        //final url = "https://1173-185-165-240-189.ngrok-free.app";
        //final token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJFYmFhIiwianRpIjoiRWJhYSIsImV4cCI6MTc0OTM5NTEwNCwibmJmIjoxNzQ5MzgwNzA0LCJpYXQiOjE3NDkzODA3MDQsImlzcyI6ImRldmtleSIsInZpZGVvIjp7InJvb21Kb2luIjp0cnVlLCJyb29tIjoidGhlcm9vbSJ9fQ.XeY-i990LsYgMwMyOZLTjDmOBf2fCse_KqC5TnPcGjs";
        final url = "wss://flutterpoi-ar6hq9rt.livekit.cloud";
        final token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NjAyNDc5NTYsImlzcyI6IkFQSTlVNVJXbVpOM2UzOCIsIm5iZiI6MTc1MDMzNzk1Nywic3ViIjoiRGFuIiwidmlkZW8iOnsiY2FuUHVibGlzaCI6dHJ1ZSwiY2FuUHVibGlzaERhdGEiOnRydWUsImNhblN1YnNjcmliZSI6dHJ1ZSwicm9vbSI6ImRlYmF0ZSIsInJvb21Kb2luIjp0cnVlfX0.PnadOPZOq7qAJ9dFlsjilSKMDqd9wpnKGfSNNZdt_8Y";
        final appCubit = context.read<AppCubit>();
        final color = ThemedColors(appCubit.isLightTheme);
        final textTheme = Theme.of(context).textTheme;
        bool isConnected = false;
        Widget? child;
        return BlocListener<CallCubit, CallStates>(
          listener: (context, state) {
            if (state is CallLocalTrackUpdatedState) {
              Timer.periodic(Duration(seconds: 2), (timer) {
                context.read<CallCubit>().updateConnectionQuality();
                //context.read<CallCubit>().sortParticipants();
              });
            }
            if (state is CallConnectingState) {
              child = Center(child: CircularProgressIndicator());
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
          },
          child: ConditionalBuilder(
            condition: state is! CallConnectingState,
            fallback: (context) => LoadingWidget(),
            builder:
                (context) => Scaffold(
                  appBar: AppBar(
                    title: Text(title),
                    actions: [
                      IconButton(
                        onPressed: () {
                          appCubit.changeTheme(!appCubit.isLightTheme);
                        },
                        icon: Icon(appCubit.isLightTheme ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          appCubit.changeLocale(appCubit.locale == "en" ? "ar" : "en");
                        },
                        icon: Icon(Icons.translate),
                      ),
                    ],
                  ),
                  body: Column(
                    children: [
                      BlocBuilder<CallCubit, CallStates>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ConnectionQualityIndicator(
                                quality: context.read<CallCubit>().connectionQuality,
                              ),
                              SizedBox(width: 10),
                            ],
                          );
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return BlocBuilder<CallCubit, CallStates>(
                                      builder: (context, state) {
                                        final cubit = context.read<CallCubit>();
                                        final participants = cubit.participants;
                                        final totalItems = 1 + participants.length + 10; // 1 for local + remotes
                                        final itemsPerPage = 6;
                                        final pageCount = (totalItems / itemsPerPage).ceil();
                                        return PageView.builder(
                                          controller: _controller,
                                          scrollDirection: Axis.vertical,
                                          physics: const InstantSnapScrollPhysics(),
                                          itemCount: pageCount,
                                          itemBuilder: (context, pageIndex) {
                                            final int start = pageIndex * itemsPerPage;
                                            final int end = (start + itemsPerPage).clamp(0, totalItems);
                                            final items = List.generate(end - start, (i) => start + i);

                                            return Column(
                                              children: [
                                                Expanded(
                                                  child: GridView.builder(
                                                    shrinkWrap: false,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: isTablet ? 3 : 2, // 2 per row
                                                      mainAxisSpacing: 5,
                                                      crossAxisSpacing: 5,
                                                      childAspectRatio: 1 / 1,
                                                      mainAxisExtent: isTablet ? constraints.maxHeight/2 - 3 : constraints.maxHeight/3 - 5.01,
                                                    ),
                                                    itemCount: items.length,
                                                    itemBuilder: (context, index) {
                                                      final actualIndex = items[index];
                                                      if (actualIndex == 0) {
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                            color: color.darkerOrLighter,
                                                            borderRadius: BorderRadius.circular(widgetBorderRadius+3),
                                                            border: Border.all(
                                                              color: color.darkerOrLighter,
                                                              width: 3,
                                                            ),
                                                          ),
                                                          child: LocalVideoCard(
                                                            bgColor: color.darkerOrLighter,
                                                            textTheme: textTheme,
                                                          ),
                                                        );
                                                      } else {
                                                        //final participant = participants[actualIndex - 1];
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                            color: color.darkerOrLighter,
                                                            borderRadius: BorderRadius.circular(widgetBorderRadius+3),
                                                            border: Border.all(
                                                              color: color.darkerOrLighter,
                                                              width: 3,
                                                            ),
                                                          ),
                                                          child: LocalVideoCard(
                                                            bgColor: color.darkerOrLighter,
                                                            textTheme: textTheme,
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: 5,),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                  }
                                ),
                              ),
                              BlocBuilder<CallCubit, CallStates>(
                                builder: (context, state) {
                                  final cubit = context.read<CallCubit>();
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 40.0),
                                    child:
                                    cubit.localParticipant == null
                                        ? ElevatedButton(
                                      onPressed:
                                          isConnected
                                              ? null
                                              : () {
                                                cubit.connectToRoom(url: url, token: token);
                                              },
                                      child: Text(context.loc.startCall),
                                    )
                                        :SizedBox()
                                    ,
                                  );
                                },
                              ),
                              BlocBuilder<CallCubit, CallStates>(
                                builder: (context, state) {
                                  final cubit = context.read<CallCubit>();
                                  return Row(
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
                                      const SizedBox(width: 20),
                                      ToggleCircleButton(
                                        isEnabled: cubit.isCameraEnabled,
                                        enabledIcon: Icons.control_point,
                                        disabledIcon: Icons.control_point,
                                        isLightTheme: appCubit.isLightTheme,
                                        onPressed: () => cubit.sendPOIRequest(),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          ),
        );
      },
    );
  }

}

// API secret: BVRgH7zHOl9J53zhUu9Af4ws8XKS7PnIfyBPxK9R0Cq
// API key: API9U5RWmZN3e38
// token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NTkzMDQ3MTAsImlzcyI6IkFQSTlVNVJXbVpOM2UzOCIsIm5iZiI6MTc0OTMwNDcxMSwic3ViIjoiQWtyYW0iLCJ2aWRlbyI6eyJjYW5QdWJsaXNoIjp0cnVlLCJjYW5QdWJsaXNoRGF0YSI6dHJ1ZSwiY2FuU3Vic2NyaWJlIjp0cnVlLCJyb29tIjoiZGViYXRlIiwicm9vbUpvaW4iOnRydWV9fQ.mYjF5IU1sGbaewvWppKMJ5qJNMOTB5rsibsrwgcx9UQ";
// url: wss://flutterpoi-ar6hq9rt.livekit.cloud


