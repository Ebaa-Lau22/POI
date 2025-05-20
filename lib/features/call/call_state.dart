part of 'call_cubit.dart';

abstract class CallStates {}

class CallInitialState extends CallStates {}

class CallConnectingState extends CallStates {}

class CallConnectedState extends CallStates {
  final LocalVideoTrack? localTrack;
  CallConnectedState({required this.localTrack});
}

class CallRemoteTrackReceivedState extends CallStates {
  final RemoteVideoTrack remoteTrack;
  CallRemoteTrackReceivedState({required this.remoteTrack});
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
