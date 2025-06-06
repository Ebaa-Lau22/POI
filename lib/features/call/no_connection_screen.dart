import 'package:flutter/material.dart';

class NoConnectionScreen extends StatelessWidget {
  final String reason;
  final VoidCallback onRetry;

  const NoConnectionScreen({
    super.key,
    required this.reason,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.8),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wifi_off, color: Colors.white, size: 64),
          const SizedBox(height: 16),
          Text(
            'Disconnected',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            reason,
            style: TextStyle(color: Colors.white70, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: Icon(Icons.refresh),
            label: Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
