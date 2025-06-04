import 'package:flutter/material.dart';

class ConnectionLostDialog extends StatelessWidget {
  final VoidCallback onReconnect;

  const ConnectionLostDialog({super.key, required this.onReconnect});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off, size: 60, color: Colors.redAccent),
            const SizedBox(height: 16),
            const Text(
              'Connection Lost',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onReconnect,
              icon: Icon(Icons.refresh),
              label: Text('Reconnect'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
