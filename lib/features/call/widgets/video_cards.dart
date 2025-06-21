import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:poi/core/localization/l10n/context_localiztion.dart';

import '../../../core/theme/app_colors.dart';
import '../call_cubit.dart';
import 'custom_mute_indicator.dart';
import 'custom_speaking_indicator.dart';

class LocalVideoCard extends StatelessWidget {
  final Color bgColor;
  final TextTheme textTheme;
  const LocalVideoCard({super.key, required this.bgColor, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallCubit, CallStates>(
      builder: (context, state) {
        final cubit = context.read<CallCubit>();
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Container(
                color: bgColor,
                child:
                cubit.localVideoTrack != null && context.read<CallCubit>().isCameraEnabled
                    ? VideoTrackRenderer(cubit.localVideoTrack!, fit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover)
                    : Center(child: Text("", style: textTheme.bodyLarge)),
              ),
              if (!cubit.isMicEnabled) Positioned(top: 8, right: 8, child: CustomMuteIndicator(iconColor: AppColors.lightRed)),
              if (cubit.isMicEnabled)
                Positioned(
                  top: 8,
                  right: 8,
                  child: CustomSpeakingIndicator(isSpeaking: cubit.isLocalSpeaking, activeColor: AppColors.lightBlue, inactiveColor: Colors.grey),
                ),
              /*if (cubit.isMicEnabled && audioTrack != null && !cubit.isCameraEnabled)
                                            Center(
                                              */
              /*top: 10,
                                              right: 10,
                                              left: 10,
                                              bottom: 10,*/
              /*
                                              child: SizedBox(
                                                height: 60,
                                                width: 60,
                                                child: SoundWaveformWidget(
                                                  key: ValueKey('${audioTrack?.hashCode}-${cubit.isMicEnabled}'),
                                                  audioTrack: audioTrack!,
                                                  width: 4,
                                                  barCount: 3,
                                                ),
                                              ),
                                            ),*/
            ],
          ),
        );
      },
    );
  }
}

class RemoteVideoCard extends StatelessWidget {
  final Color bgColor;
  final TextTheme textTheme;
  final RemoteParticipant participant;
  const RemoteVideoCard({
    super.key,
    required this.bgColor,
    required this.textTheme,
    required this.participant,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BlocBuilder<CallCubit, CallStates>(
        builder: (context, state) {
          final cubit = context.read<CallCubit>();
          return Container(
            color: bgColor,
            child:
            participant.hasVideo
                ? VideoTrackRenderer(
              cubit.getRemoteVideoTrackForParticipant(participant) as VideoTrack,
              fit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            )
                : Center(child: Text(context.loc.waitingForRemoteVideo, style: textTheme.bodyLarge)),
          );
        },
      ),
    );
  }
}