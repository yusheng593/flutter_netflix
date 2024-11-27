import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget(
      {super.key, required this.errorText, required this.retryFunction});

  final String errorText;
  final Function retryFunction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 60,
            color: Colors.pinkAccent,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '錯誤：$errorText',
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                retryFunction();
              },
              label: const Text('重試'))
        ],
      ),
    );
  }
}
