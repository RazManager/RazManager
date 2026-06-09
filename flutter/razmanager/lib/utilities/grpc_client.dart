import 'package:grpc/grpc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../app_model.dart';

mixin class GrpcClient {
  ClientChannel createClientChannel() => ClientChannel('app.razmanager.com',  options: const ChannelOptions(keepAlive: ClientKeepAliveOptions(pingInterval: Duration(seconds: 50),  permitWithoutCalls: true)));
  // ClientChannel createClientChannel() => ClientChannel('app.razmanager.localhost',
  //     options: ChannelOptions(
  //         keepAlive: const ClientKeepAliveOptions(pingInterval: Duration(seconds: 50), permitWithoutCalls: true),
  //         credentials: ChannelCredentials.secure(onBadCertificate: (certificate, host) => true)));

  CallOptions callOptionsFromContext(BuildContext context) {
    final model = Provider.of<AppModel>(context, listen: false);
    return CallOptions(metadata: {'Authorization': 'Bearer ${model.accessToken}'});
    //return CallOptions(timeout: const Duration(hours: 1), metadata: {'Authorization': 'Bearer ${model.accessToken}'});
  }

  CallOptions callOptionsFromAppModel(AppModel model) {
    return CallOptions(metadata: {'Authorization': 'Bearer ${model.accessToken}'});
    //return CallOptions(timeout: const Duration(hours: 1), metadata: {'Authorization': 'Bearer ${model.accessToken}'});
  }

  CallOptions callOptionsFromAccessToken(String accessToken) {
    return CallOptions(metadata: {'Authorization': 'Bearer $accessToken'});
  }
}
