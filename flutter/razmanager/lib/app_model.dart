import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import 'protobuf/razmanager/protobuf/internal/repository/user_services/tenant.pbgrpc.dart';
import 'utilities/exception_message.dart';
import 'utilities/grpc_client.dart';

class AppModel extends ChangeNotifier with GrpcClient, ExceptionMessage {
  AppModel() {
    _platForm();
  }

  late String applicationVersion;
  int menuIndex = 0;
  bool busy = false;
  final exceptionStreamController = StreamController<String>.broadcast();

  String? accessToken;
  String? refreshToken;
  String? tenantId;
  TenantRead? tenantRead;
  Timer? tokenTimer;
  late String locale;

  void _platForm() async {
    final packageInfo = await PackageInfo.fromPlatform();
    applicationVersion = packageInfo.version;

    initializeDateFormatting(Platform.localeName);
    locale = Platform.localeName;
    debugPrint(Platform.localeName);

    final networkInfo = NetworkInfo();

    final wifiName = await networkInfo.getWifiName(); // "FooNetwork"
    final wifiBSSID = await networkInfo.getWifiBSSID(); // 11:22:33:44:55:66
    final wifiIP = await networkInfo.getWifiIP(); // 192.168.1.43
    final wifiIPv6 = await networkInfo.getWifiIPv6(); // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
    final wifiSubmask = await networkInfo.getWifiSubmask(); // 255.255.255.0
    final wifiBroadcast = await networkInfo.getWifiBroadcast(); // 192.168.1.255
    final wifiGateway = await networkInfo.getWifiGatewayIP(); // 192.168.1.1
  }

  void setBusy({required bool value, required bool notify}) {
    busy = value;
    if (notify) {
      notifyListeners();
    }
  }

  bool isAuthenticated() => accessToken != null;

  Future<void> tokenSignIn(String username, String password) async {
    final body = <String, String>{'grant_type': 'password', 'client_id': 'app', 'username': username, 'password': password, 'scope': 'offline_access app_api'};
    await _token(body);
    notifyListeners();
  }

  Future<void> tokenSignOut() async {
    await tokenClear();
    notifyListeners();
  }

  Future<void> _tokenRefresh({required bool throwError}) async {
    if (refreshToken != null) {
      final body = <String, String>{'grant_type': 'refresh_token', 'client_id': 'app', 'refresh_token': refreshToken!};
      if (tenantId != null) {
        body.addEntries({'tenantId': tenantId!}.entries);
      }
      try {
        await _token(body);
      } on Exception catch (exception) {
        if (throwError) {
          rethrow;
        } else {
          exceptionStreamController.add(exceptionMessage(exception));
        }
      }
    }
  }

  Future<void> tokenRefreshIfNeeded() async {
    if (refreshToken == null || refreshToken!.isEmpty) {
      final sharedPreferences = await SharedPreferences.getInstance();
      refreshToken = sharedPreferences.getString('refreshToken');
      if (refreshToken != null && refreshToken!.isNotEmpty) {
        await _tokenRefresh(throwError: true);
      }
    }
  }

  Future<void> _token(Map<String, String> body) async {
    try {
      //final response = await http.post(Uri.parse("https://identity.razmanager.localhost/connect/token"), body: body);
      final response = await http.post(Uri.parse("https://identity.razmanager.com/connect/token"), body: body);
      if (response.statusCode == 200) {
        final responseMap = json.decode(response.body) as Map<String, dynamic>;
        accessToken = responseMap['access_token'];
        refreshToken = responseMap['refresh_token'];
        final expiresIn = responseMap['expires_in'];

        final sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString('refreshToken', refreshToken!);

        debugPrint("accessToken ${DateTime.now()} $accessToken");

        if (tokenTimer != null) {
          tokenTimer!.cancel;
        }
        tokenTimer = Timer(Duration(seconds: expiresIn - 60), () => _tokenRefresh(throwError: true));
      } else {
        await tokenClear();
        //throw PermissionDeniedException();
      }
    } on Exception catch (exception) {
      if (tokenTimer != null) {
        tokenTimer!.cancel;
      }
      tokenTimer = Timer(Duration(seconds: 60), () => _tokenRefresh(throwError: true));
      exceptionStreamController.add(exceptionMessage(exception));
    }
  }

  Future<void> tokenClear() async {
    accessToken = null;
    refreshToken = null;
    tenantId = null;
    tenantRead = null;

    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('refreshToken', "");

    if (tokenTimer != null) {
      tokenTimer!.cancel;
      tokenTimer = null;
    }
  }

  Future<void> tenantClear() async {
    tenantId = null;
    tenantRead = null;
    await _tokenRefresh(throwError: false);
  }

  Future<void> tenantRefresh(String tenantId) async {
    this.tenantId = tenantId;
    await _tokenRefresh(throwError: true);

    final clientChannel = createClientChannel();
    final client = TenantServiceClient(clientChannel, options: callOptionsFromAccessToken(accessToken!));
    tenantRead = await client.read(Empty());
    await clientChannel.shutdown();
  }
}
