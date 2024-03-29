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

dynamic connect(String url) async {
  final channel = HtmlWebSocketChannel.connect(url);
  final ws = new json_rpc.Client(channel.cast());

  var callZome = (String instanceId, String zome, String func, Map args) async {
    var callObject = {
      'instance_id': instanceId,
      'zome': zome,
      'function': func,
      ...args,
    };
    try {
      var result = await ws.sendRequest('call', callObject);
      return result;
    } catch (e) {
      return e;
    }
  };

  ws.listen();

  return callZome;
}
