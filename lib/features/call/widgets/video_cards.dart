import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:poi/core/constants/constants.dart';
import '../../../core/theme/app_colors.dart';
import '../call_cubit.dart';
import 'custom_mute_indicator.dart';
import 'custom_speaking_indicator.dart';

class VideoCard extends StatelessWidget {
  final Color bgColor;
  final TextTheme textTheme;
  final double mainAxis;
  final bool videoCondition;
  final VideoTrack? videoTrack;
  final Participant? participant;
  final bool isMicEnabled;
  final bool isParticipantSpeaking;
  const VideoCard({
    super.key,
    required this.bgColor,
    required this.textTheme,
    required this.mainAxis,
    required this.videoCondition,
    required this.videoTrack,
    required this.participant,
    required this.isMicEnabled,
    required this.isParticipantSpeaking

  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallCubit, CallStates>(
      builder: (context, state) {
        final cubit = context.read<CallCubit>();
        return ClipRRect(
          borderRadius: BorderRadius.circular(widgetBorderRadius),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Container(
                color: bgColor,
                child: videoCondition && videoTrack != null
                    ? VideoTrackRenderer(videoTrack!, fit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover)
                    : Center(
                  child: Material(
                    shape: const CircleBorder(),
                    color: AppColors.lightRed, //TODO
                    child: SizedBox(
                      width: 42,
                      height: 42,
                      child: Center(
                        child: Text(
                          cubit.getParticipantFirstName(participant)[0],
                          style: TextStyle(color: AppColors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.directional(
                textDirection: Directionality.of(context),
                bottom: 8,
                start: 8,
                child: SizedBox(
                  width: (mainAxis - 8)/2,
                  child: Text(
                    cubit.getParticipantFirstName(participant),
                    style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (!isMicEnabled) Positioned(top: 8, right: 8, child: CustomMuteIndicator(iconColor: AppColors.lightRed)),
              if (isMicEnabled)
                Positioned(
                  top: 8,
                  right: 8,
                  child: CustomSpeakingIndicator(
                    isSpeaking: isParticipantSpeaking,
                    activeColor: AppColors.lightBlue,
                    inactiveColor: Colors.grey,
                  ),
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

class LocalVideoCard extends StatelessWidget {
  final Color bgColor;
  final TextTheme textTheme;
  final double mainAxis;
  const LocalVideoCard({super.key, required this.bgColor, required this.textTheme, required this.mainAxis});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallCubit, CallStates>(
      builder: (context, state) {
        final cubit = context.read<CallCubit>();
        return VideoCard(
          bgColor: bgColor,
          textTheme: textTheme,
          mainAxis: mainAxis,
          videoCondition: cubit.localVideoTrack != null && context.read<CallCubit>().isCameraEnabled,
          videoTrack: cubit.localVideoTrack,
          participant: cubit.localParticipant,
          isMicEnabled: cubit.isMicEnabled,
          isParticipantSpeaking: cubit.isLocalSpeaking,
        );
      },
    );
  }

}

class RemoteVideoCard extends StatelessWidget {
  final Color bgColor;
  final TextTheme textTheme;
  final int participantIndex;
  final double mainAxis;
  const RemoteVideoCard({super.key, required this.bgColor, required this.textTheme, required this.mainAxis, required this.participantIndex});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widgetBorderRadius),
      child: BlocBuilder<CallCubit, CallStates>(
        builder: (context, state) {
          final cubit = context.read<CallCubit>();
          return VideoCard(
            bgColor: bgColor,
            textTheme: textTheme,
            mainAxis: mainAxis,
            videoCondition: cubit.participantsHasVideo[participantIndex],
            videoTrack: cubit.getRemoteVideoTrackForParticipant(cubit.participants[participantIndex]) as VideoTrack,
            participant: cubit.participants[participantIndex],
            isMicEnabled: cubit.participantsHasAudio[participantIndex],
            isParticipantSpeaking: cubit.participantsIsSpeaking[participantIndex],
          );
        },
      ),
    );
  }
}
