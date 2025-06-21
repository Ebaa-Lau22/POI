part of 'call_cubit.dart';

abstract class CallStates {}

class CallInitialState extends CallStates {}

class CallConnectingState extends CallStates {}

class CallRemoteTrackReceivedState extends CallStates {}

class CallLocalTrackUpdatedState extends CallStates {}

class CallLocalSpeakingStateUpdated extends CallStates {}

class LocalConnectionQualityUpdatedState extends CallStates {
  final ConnectionQuality quality;
  LocalConnectionQualityUpdatedState({required this.quality});
}

class CallDisconnectedState extends CallStates {
  final String reason;
  CallDisconnectedState({required this.reason});
}

class CallErrorState extends CallStates {
  final String message;
  CallErrorState(this.message);
}

class CallRemoteSpeakingState extends CallStates {
  final String participantSid;
  final bool isSpeaking;

  CallRemoteSpeakingState({
    required this.participantSid,
    required this.isSpeaking,
  });
}

class ChangeThemeState extends CallStates {}

class DebateToggleLocalMicState extends CallStates {}

class DebateToggleLocalCameraState extends CallStates {}
