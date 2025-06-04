part of 'call_cubit.dart';

abstract class CallStates {}

class CallInitialState extends CallStates {}

class CallConnectingState extends CallStates {}

class CallRemoteTrackReceivedState extends CallStates {
  final RemoteVideoTrack remoteTrack;
  CallRemoteTrackReceivedState({required this.remoteTrack});
}

class CallLocalTrackUpdatedState extends CallStates {
  final LocalVideoTrack? localTrack;
  final ConnectionQuality quality;
  CallLocalTrackUpdatedState({required this.localTrack, required this.quality});
}

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

class ChangeThemeState extends CallStates {}

class DebateToggleLocalMicState extends CallStates {}

class DebateToggleLocalCameraState extends CallStates {}

