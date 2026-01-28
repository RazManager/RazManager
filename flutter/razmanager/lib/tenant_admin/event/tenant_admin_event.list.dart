import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/event.pbgrpc.dart';
import '../../refresh_model.dart';
import '../../utilities/crud_master_list_base.dart';

class TenantAdminEventList extends StatefulWidget {
  const TenantAdminEventList({super.key});

  @override
  State<TenantAdminEventList> createState() => _TenantAdminEventListState();
}

class _TenantAdminEventListState extends CrudMasterListStateBase<EventList, TenantAdminEventList> {
  _TenantAdminEventListState()
      : super(path: '/tenant-admin/events', header: 'Events', body: _TenantAdminEventListBody());

  @override
  Future list(ListRequest listRequest) async {
    final client = EventServiceClient(clientChannel!, options: callOptionsFromContext(context));
    final response = await client.list(listRequest);
    return response.result;
  }
}

class _TenantAdminEventListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminEventListState>()!;
    return Consumer<RefreshModel>(builder: (context, model, child) {
      return ListView.separated(
        key: ObjectKey(state.itemsRefreshedAt),
        controller: state.scrollController,
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          final item = state.items.elementAt(index);
          return ListTile(
            leading: item.image.hasValue()
                ? CircleAvatar(foregroundImage: MemoryImage(Uint8List.fromList(item.image.value)))
                : const Icon(Icons.event, size: 40),
            title: Text(item.name),
            subtitle: item.description.hasValue() ? Text(item.description.value) : null,
            onTap: () =>
                context.push('/tenant-admin/events/${item.id}?etag=${item.etag}', extra: state.refreshItemsCallback),
          );
        },
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Divider(),
          );
        },
      );
    });
  }
}
