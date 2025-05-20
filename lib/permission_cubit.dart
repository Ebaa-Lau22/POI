import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionState {
  final bool granted;
  final bool deniedPermanently;

  PermissionState({required this.granted, this.deniedPermanently = false});
}

class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit() : super(PermissionState(granted: false));

  //static const _storage = FlutterSecureStorage();
  static const _keyAskedOnce = 'permissions_requested';

  Future<void> checkAndRequestPermissions() async {
    /*final hasRequested = await _storage.read(key: _keyAskedOnce);
    if (hasRequested == 'true') {
      final granted = await _permissionsGranted();
      emit(PermissionState(granted: granted));
      return;
    }*/

    final cameraStatus = await Permission.camera.request();
    final micStatus = await Permission.microphone.request();

    final allGranted = cameraStatus.isGranted && micStatus.isGranted;

    if (allGranted) {
      //await _storage.write(key: _keyAskedOnce, value: 'true');
      emit(PermissionState(granted: true));
    } else {
      final permanentlyDenied =
          cameraStatus.isPermanentlyDenied || micStatus.isPermanentlyDenied;
      emit(PermissionState(granted: false, deniedPermanently: permanentlyDenied));
    }
  }

  Future<bool> _permissionsGranted() async {
    final camera = await Permission.camera.isGranted;
    final mic = await Permission.microphone.isGranted;
    return camera && mic;
  }
}