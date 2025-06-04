import 'package:bloc/bloc.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:poi/features/call/connection_states.dart';

class ConnectionCubit extends Cubit<ConnectionStates>{
  ConnectionCubit() : super(ConnectionInitialState());

  ConnectionQuality getConnectionQuality(ConnectionQuality quality){
    emit(ConnectionUpdatedState(quality));
    return quality;
  }
}