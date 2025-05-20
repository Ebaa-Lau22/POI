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

  Future<void> connectToRoom({
    required String url,
    required String token,
  }) async {
    emit(CallConnectingState());

    try {
      final roomOptions = RoomOptions(
        adaptiveStream: true,
        dynacast: true,
      );

      _room = Room();
      _roomEvents = _room!.createListener();

      _registerRoomListeners();

      await _room!.connect(url, token, roomOptions: roomOptions);

      // Enable camera and mic after joining
      await _room!.localParticipant?.setCameraEnabled(true);
      await _room!.localParticipant?.setMicrophoneEnabled(true);

      emit(CallConnectedState(localTrack: _getLocalVideoTrack()));
    } catch (e) {
      emit(CallErrorState('Failed to connect: $e'));
    }
  }

  void _registerRoomListeners() {
    if (_roomEvents == null || _room == null) return;

    _roomEvents!
      ..on<TrackSubscribedEvent>((event) {
        final track = event.track;
        if (track is RemoteVideoTrack) {
          emit(CallRemoteTrackReceivedState(remoteTrack: track));
        }
      })
      ..on<RoomDisconnectedEvent>((event) {
        emit(CallDisconnectedState(reason: event.reason.toString() ?? 'Disconnected'));
      });
  }

  LocalVideoTrack? _getLocalVideoTrack() {
    return _room?.localParticipant?.videoTrackPublications.firstOrNull?.track;
  }

  Future<void> disconnect() async {
    await _room?.disconnect();
    await _roomEvents?.dispose();
    emit(CallDisconnectedState(reason: "User left the call"));
  }

  @override
  Future<void> close() async {
    await _room?.dispose();
    await _roomEvents?.dispose();
    return super.close();
  }
}
