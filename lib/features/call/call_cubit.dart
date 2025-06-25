import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livekit_client/livekit_client.dart';
import 'dart:convert';

import 'package:poi/widgets/participant_info.dart';

import '../../core/network/network_info.dart';
import '../../di/injection_container.dart' as di;
part 'call_state.dart';

class CallCubit extends Cubit<CallStates> {
  CallCubit() : super(CallInitialState());

  Room? _room;
  EventsListener<RoomEvent>? _roomEvents;
  Timer? _connectionQualityTimer;
  ConnectionQuality connectionQuality = ConnectionQuality.unknown;
  List<RemoteParticipant> participants = [];
  List<bool> participantsHasAudio = [];
  List<bool> participantsHasVideo = [];
  List<bool> participantsIsSpeaking = [];

  LocalParticipant? localParticipant;
  EventsListener<ParticipantEvent>? _localParticipantEvents;

  LocalVideoTrack? localVideoTrack;
  LocalAudioTrack? localAudioTrack;
  bool isLocalSpeaking = false;

  bool isMicEnabled = false;
  bool isCameraEnabled = false;

  //NetworkInfo networkInfo = di.sl();
  int times = 0;

  Future<void> connectToRoom({required String url, required String token}) async {
    emit(CallConnectingState());

    try {
      final roomOptions = RoomOptions(adaptiveStream: true, dynacast: true);

      _room = Room();
      _roomEvents = _room!.createListener();

      _registerRoomListeners();
      localParticipant = _room!.localParticipant;
      await _room!.connect(url, token, roomOptions: roomOptions);
      await _room!.localParticipant?.setCameraEnabled(false);
      await _room!.localParticipant?.setMicrophoneEnabled(false);
      localVideoTrack = _getLocalVideoTrack();
      localAudioTrack = _getLocalAudioTrack();
      isLocalSpeaking = _getParticipantIsSpeaking(_room!.localParticipant);
      emit(CallLocalTrackUpdatedState());
    } catch (e) {
      emit(CallErrorState('Failed to connect: $e'));
    }
  }

  void updateConnectionQuality() {
    if (!isClosed) {
      connectionQuality = _getConnectionQuality();
    }
  }

  void toggleMic() {
    isMicEnabled = !isMicEnabled;
    _room!.localParticipant?.setMicrophoneEnabled(isMicEnabled);
    emit(DebateToggleLocalMicState());
    localVideoTrack = _getLocalVideoTrack();
    localAudioTrack = _getLocalAudioTrack();
    isLocalSpeaking = _getParticipantIsSpeaking(_room!.localParticipant);
    emit(CallLocalTrackUpdatedState());
  }

  void toggleCamera() {
    isCameraEnabled = !isCameraEnabled;
    _room!.localParticipant?.setCameraEnabled(isCameraEnabled);

    emit(DebateToggleLocalCameraState());
    localVideoTrack = _getLocalVideoTrack();
    localAudioTrack = _getLocalAudioTrack();
    isLocalSpeaking = _getParticipantIsSpeaking(_room!.localParticipant);
    emit(CallLocalTrackUpdatedState());
  }

  ConnectionQuality _getConnectionQuality() {
    return _room?.localParticipant?.connectionQuality ?? ConnectionQuality.unknown;
  }

  void _registerRoomListeners() {
    if (_roomEvents == null || _room == null) return;
    _roomEvents!
      ..on<LocalTrackPublishedEvent>((event) {
        print('Event: LocalTrackPublishedEvent');
        sortParticipants();
        emit(CallLocalTrackUpdatedState());
      })
      ..on<LocalTrackUnpublishedEvent>((event) {
        print('Event: LocalTrackUnpublishedEvent');
        if (event.publication.track is LocalVideoTrack) {
          localVideoTrack = null;
          localAudioTrack = null;
          isLocalSpeaking = false;
          emit(CallLocalTrackUpdatedState());
        }
      })
      ..on<TrackSubscribedEvent>((event) {
        final track = event.track;
        print('Event: TrackSubscribedEvent -> ${track.sid}, kind: ${track.kind}');
        sortParticipants();
      })
      ..on<TrackUnsubscribedEvent>((event) {
        print('Event: TrackUnsubscribedEvent -> ${event.track.sid}');
      })
      ..on<TrackPublishedEvent>((event) {
        print('Event: TrackPublishedEvent -> Track SID: ${event.publication.sid}');
      })
      ..on<TrackUnpublishedEvent>((event) {
        print('Event: TrackUnpublishedEvent -> Track SID: ${event.publication.sid}');
      })
      ..on<ParticipantConnectedEvent>((event) {
        print('Event: ParticipantConnectedEvent -> ${event.participant.identity}');
      })
      ..on<ParticipantDisconnectedEvent>((event) {
        print('Event: ParticipantDisconnectedEvent -> ${event.participant.identity}');
      })
      ..on<RoomDisconnectedEvent>((event) {
        print('Event: RoomDisconnectedEvent -> Reason: ${event.reason}');
        emit(CallDisconnectedState(reason: event.reason.toString()));
      });

  }

  void sortParticipants() async{
    if (_room != null) {
      localParticipant = _room!.localParticipant;
      _localParticipantEvents = localParticipant?.createListener();
      if (_localParticipantEvents != null) {
        _localParticipantEvents!
          ..on<SpeakingChangedEvent>((event) {
            isLocalSpeaking = event.speaking;
            emit(CallLocalSpeakingStateUpdated());
          })
          ..on<LocalConnectionQualityUpdatedState>((event) {
            print(event.quality);
          })
          ..on<RoomReconnectingEvent>((event){
            print("reconnecting");
        });
      }
      /*if(!await networkInfo.isConnected){
        connectionQuality = ConnectionQuality.lost;
        if(times++<10) print("network info");
        emit(CallLocalTrackUpdatedState());
      }*/
      emit(CallLocalTrackUpdatedState());

      localVideoTrack = _getLocalVideoTrack();
      localAudioTrack = _getLocalAudioTrack();
      isLocalSpeaking = _getParticipantIsSpeaking(_room!.localParticipant);
      List<RemoteParticipant> tmpParticipants = [];
      List<bool> tmpHasAudio = [];
      List<bool> tmpHasVideo = [];
      List<bool> tmpIsSpeaking = [];
      for (var participant in _room!.remoteParticipants.values) {
        tmpParticipants.add(participant);
        tmpHasAudio.add(_getIfRemoteParticipantMicOn(participant));
        tmpHasVideo.add(_getIfRemoteParticipantCameraOn(participant));
        participant.createListener().on<SpeakingChangedEvent>((event){
          tmpIsSpeaking.add(event.speaking);
        });
      }
      participants = tmpParticipants;
      participantsHasAudio = tmpHasAudio;
      participantsHasVideo = tmpHasVideo;
      participantsIsSpeaking = tmpIsSpeaking;
      emit(CallRemoteTrackReceivedState());
    }
  }

  String getParticipantFirstName(Participant? participant) {

    if (participant == null) return "Ebaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
    String name = participant.name;
    return name.isNotEmpty ? participant.name.split(" ")[0] : "User";
  }

  LocalVideoTrack? _getLocalVideoTrack() {
    return _room?.localParticipant?.videoTrackPublications.firstOrNull?.track;
  }

  LocalAudioTrack? _getLocalAudioTrack() {
    return _room?.localParticipant?.audioTrackPublications.firstOrNull?.track;
  }

  bool _getParticipantIsSpeaking(Participant? participant) {
    double level = participant?.audioLevel ?? 0;
    return level > 3.0;
  }

  bool _getIfRemoteParticipantMicOn(RemoteParticipant participant){
    final audioPublication = participant.getTrackPublicationBySource(TrackSource.microphone);
    return audioPublication != null && audioPublication.track != null && audioPublication.track?.muted == false;
  }

  bool _getIfRemoteParticipantCameraOn(RemoteParticipant participant){
    final videoPublication = participant.getTrackPublicationBySource(TrackSource.camera);
    return videoPublication != null && videoPublication.track != null && videoPublication.track?.muted == false;
  }

  RemoteVideoTrack? getRemoteVideoTrackForParticipant(RemoteParticipant? participant) {
    if (participant == null) return null;
    final v = participant.videoTrackPublications.firstOrNull;
    if (v != null) return v.track;
    return null;
  }

  void sendPOIRequest() {
    final data = jsonEncode({'type': 'poi_request', 'message': 'Participant X requests a POI'});

    _room?.localParticipant?.publishData(utf8.encode(data), reliable: true, topic: 'debate-events');
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
