import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/device.pbgrpc.dart';
import '../../refresh_model.dart';
import '../../utilities/crud_master_list_base.dart';
import '../../utilities/date_formatter.dart';

class TenantAdminDeviceList extends StatefulWidget {
  const TenantAdminDeviceList({super.key});

  @override
  State<TenantAdminDeviceList> createState() => _TenantAdminDeviceListState();
}

class _TenantAdminDeviceListState extends CrudMasterListStateBase<DeviceList, TenantAdminDeviceList> {
  _TenantAdminDeviceListState() : super(path: '/tenant-admin/devices', header: 'Devices', body: _TenantAdminDeviceListBody());

  @override
  Future list(ListRequest listRequest) async {
    final client = DeviceServiceClient(clientChannel!, options: callOptionsFromContext(context));
    final response = await client.list(listRequest);
    return response.result;
  }
}

class _TenantAdminDeviceListBody extends StatelessWidget with DateFormatter {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminDeviceListState>()!;
    return Consumer<RefreshModel>(
      builder: (context, model, child) {
        return ListView.separated(
          key: ObjectKey(state.itemsRefreshedAt),
          controller: state.scrollController,
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            final item = state.items.elementAt(index);
            return ListTile(
              leading: !item.simulated ? const Icon(Icons.devices_other, size: 40) : const Icon(Icons.device_unknown, size: 40),
              title: Text(item.name),
              subtitle: !item.simulated
                  ? Row(
                      children: [
                        item.connected ? const Icon(Icons.cloud) : const Icon(Icons.cloud_off),
                        if (item.lastConnectedAt.hasSeconds()) ...[SizedBox(width: 16), Text(dateTimeFormat(item.lastConnectedAt.toDateTime(toLocal: true)))],
                      ],
                    )
                  : null,
              trailing: IntrinsicWidth(
                child: Row(
                  children: [
                    TextButton(
                      child: const Text('Edit'),
                      onPressed: () => !item.simulated
                          ? context.push('/tenant-admin/devices/${item.id}?etag=${item.etag}', extra: state.refreshItemsCallback)
                          : context.push('/tenant-admin/devices/${item.id}/simulated?etag=${item.etag}', extra: state.refreshItemsCallback),
                    ),
                    const SizedBox(width: 16),
                    TextButton(child: const Text('Monitor'), onPressed: () => context.push('/tenant-admin/devices/${item.id}/view')),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Padding(padding: EdgeInsets.only(left: 16, right: 16), child: Divider());
          },
        );
      },
    );
  }
}
