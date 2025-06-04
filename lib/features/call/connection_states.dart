import 'package:livekit_client/livekit_client.dart';

abstract class ConnectionStates {}

class ConnectionInitialState extends ConnectionStates {}

class ConnectionUpdatedState extends ConnectionStates {
  final ConnectionQuality quality;
  ConnectionUpdatedState(this.quality);
}