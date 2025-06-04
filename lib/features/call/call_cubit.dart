import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:poi/core/storage/preferences_database.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/di/injection_container.dart' as di;

part 'call_state.dart';

class CallCubit extends Cubit<CallStates> {
  CallCubit() : super(CallInitialState());

  Room? _room;
  EventsListener<RoomEvent>? _roomEvents;
  RemoteVideoTrack? remoteTrack;
  Timer? _connectionQualityTimer;
  ConnectionQuality connectionQuality = ConnectionQuality.unknown;

  Future<void> connectToRoom({
    required String url,
    required String token,
  }) async {
    emit(CallConnectingState());

    try {
      final roomOptions = RoomOptions(adaptiveStream: true, dynacast: true);

      _room = Room();
      _roomEvents = _room!.createListener();

      _registerRoomListeners();

      await _room!.connect(url, token, roomOptions: roomOptions);
      await _room!.localParticipant?.setCameraEnabled(false);
      await _room!.localParticipant?.setMicrophoneEnabled(false);
      emit(CallLocalTrackUpdatedState(
        localTrack: _getLocalVideoTrack(),
        quality: _getConnectionQuality(),
      ));
    } catch (e) {
      emit(CallErrorState('Failed to connect: $e'));
    }
  }

  void updateConnectionQuality(){
    _connectionQualityTimer = Timer.periodic(Duration(milliseconds: 400), (_) {
      if(!isClosed) {
        connectionQuality = _getConnectionQuality();
      }
    });
  }

  bool isMicEnabled = false;
  bool isCameraEnabled = false;
  void toggleMic() {
    isMicEnabled = !isMicEnabled;
    _room!.localParticipant?.setMicrophoneEnabled(isMicEnabled);
    emit(DebateToggleLocalMicState());
    emit(CallLocalTrackUpdatedState(
      localTrack: _getLocalVideoTrack(),
      quality: _getConnectionQuality(),
    ));  }

  void toggleCamera() {
    isCameraEnabled = !isCameraEnabled;
    _room!.localParticipant?.setCameraEnabled(isCameraEnabled);

    emit(DebateToggleLocalCameraState());
    emit(CallLocalTrackUpdatedState(
      localTrack: _getLocalVideoTrack(),
      quality: _getConnectionQuality(),
    ));  }

  ConnectionQuality _getConnectionQuality(){
    return _room?.localParticipant?.connectionQuality ?? ConnectionQuality.unknown;
  }

  void _registerRoomListeners() {
    if (_roomEvents == null || _room == null) return;

    _roomEvents!
      ..on<LocalTrackPublishedEvent>((event) {
        if (event.publication.track is LocalVideoTrack) {
          emit(
            CallLocalTrackUpdatedState(
              localTrack: event.publication.track as LocalVideoTrack,
              quality: _getConnectionQuality(),
            ),
          );
        }
      })
      ..on<LocalTrackUnpublishedEvent>((event) {
        if (event.publication.track is LocalVideoTrack) {
          emit(CallLocalTrackUpdatedState(localTrack: null, quality: _getConnectionQuality()));
        }
      })
      ..on<TrackSubscribedEvent>((event) {
        final track = event.track;
        if (track is RemoteVideoTrack) {
          emit(CallRemoteTrackReceivedState(remoteTrack: track));
        }
      })
      ..on<RoomDisconnectedEvent>((event) {
        emit(CallDisconnectedState(reason: event.reason.toString()));
      });
  }

  LocalVideoTrack? _getLocalVideoTrack() {
    return _room?.localParticipant?.videoTrackPublications.firstOrNull?.track;
  }

  Future<void> disconnect() async {
    await _room?.disconnect();
    await _roomEvents?.dispose();
    _connectionQualityTimer?.cancel();
    _connectionQualityTimer = null;
    emit(CallDisconnectedState(reason: "User left the call"));
  }

  @override
  Future<void> close() async {
    await _room?.dispose();
    await _roomEvents?.dispose();
    _connectionQualityTimer?.cancel();
    _connectionQualityTimer = null;
    return super.close();
  }
}
