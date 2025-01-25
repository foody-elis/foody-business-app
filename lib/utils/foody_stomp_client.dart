import 'dart:convert';

import 'package:stomp_dart_client/stomp_dart_client.dart';

class FoodyStompClient {
  late final StompClient _stompClient;

  FoodyStompClient({
    required String jwt,
    required Function(StompFrame) onConnect,
  }) {
    _stompClient = StompClient(
      config: StompConfig(
        url: 'ws://10.0.2.2:8080/ws',
        webSocketConnectHeaders: {
          'Authorization': 'Bearer $jwt',
        },
        reconnectDelay: const Duration(seconds: 10),
        onConnect: onConnect,
        onStompError: (e) => print(e),
        // onDebugMessage: (d) => print(d),
        onWebSocketError: (e) => print(e),
      ),
    );

    _stompClient.activate();
  }

  StompUnsubscribe subscribe<T>({
    required String destination,
    required void Function(T) callback,
    Map<String, String>? headers,
    required T Function(Map<String, dynamic>) dtoFromJson,
  }) {
    return _stompClient.subscribe(
        destination: destination,
        headers: headers,
        callback: (frame) {
          if (frame.body != null) {
            callback(dtoFromJson(json.decode(frame.body!)));
          }
        });
  }
}
