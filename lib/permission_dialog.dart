import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void showPermissionDeniedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Permissions Required'),
      content: const Text(
        'This app needs camera and microphone access to function. '
            'Please enable them from system settings.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            openAppSettings();
            Navigator.of(ctx).pop();
          },
          child: const Text('Open Settings'),
        ),
      ],
    ),
  );
}
