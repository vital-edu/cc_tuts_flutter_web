import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:json_rpc_2/json_rpc_2.dart' as json_rpc;
import 'package:web_socket_channel/html.dart';

typedef Call = Future<Object> Function(List<String> segments);
typedef CallZome = Future<Object> Function(
    String instanceId, String zome, String func);
typedef OnSignal = void Function(void Function(Object params) callback);
typedef Close = Future<Object> Function();

const DEFAULT_TIMEOUT = 5000;

class ConnectOptsReturn {
  ConnectOptsReturn(
      {Call call,
      CallZome callZome,
      Close close,
      OnSignal onSignal,
      Object ws});
}

Future<dynamic> fetch(String config) async {
  var response = await http.get(config);
  return response;
}

final ignoreFormatExceptions =
    new StreamTransformer<Object, Object>.fromHandlers(
        handleError: (error, stackTrace, sink) {
  if (error is FormatException) return;
  sink.addError(error, stackTrace);
});

Future<dynamic> connect(String url) async {
  var channel = HtmlWebSocketChannel.connect(url);

  final ws = new json_rpc.Client(channel.cast());
  Completer c = Completer();

  try {
    ws.sendRequest(
      'call',
      {
        'instance_id': 'test-instance',
        'zome': 'hello',
        'function': 'hello_holo',
        'args': {'args': {}},
      },
    ).then((result) {
      c.complete(result);
    }).catchError((error) {
      c.completeError(error);
    });
    ws.listen();
  } catch (e) {
    c.completeError(e);
  }
}
