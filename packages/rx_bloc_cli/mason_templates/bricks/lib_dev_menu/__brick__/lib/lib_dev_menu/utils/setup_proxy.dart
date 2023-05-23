import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setupProxy(
  HttpClientAdapter httpClientAdapter,
) async {
  String proxy = (await _instance).getString('dev_menu_http_proxy') ?? '';
  (httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
    if (proxy.isNotEmpty) {
      client.findProxy = ((uri) {
        return 'PROXY $proxy:8888';
      });
      client.badCertificateCallback = ((cert, host, port) => true);
    }
    return client;
  };
}

Future<SharedPreferences> get _instance => SharedPreferences.getInstance();
