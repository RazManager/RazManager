import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/track.pbgrpc.dart';
import '../../refresh_model.dart';
import '../../utilities/crud_master_list_base.dart';

class TenantAdminTrackList extends StatefulWidget {
  const TenantAdminTrackList({super.key});

  @override
  State<TenantAdminTrackList> createState() => _TenantAdminTrackListState();
}

class _TenantAdminTrackListState extends CrudMasterListStateBase<TrackList, TenantAdminTrackList> {
  _TenantAdminTrackListState()
      : super(path: '/tenant-admin/tracks', header: 'Tracks', body: _TenantAdminTrackListBody());

  @override
  Future list(ListRequest listRequest) async {
    final client = TrackServiceClient(clientChannel!, options: callOptionsFromContext(context));
    final response = await client.list(listRequest);
    return response.result;
  }
}

class _TenantAdminTrackListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminTrackListState>()!;
    return Consumer<RefreshModel>(builder: (context, model, child) {
      return ListView.separated(
        key: ObjectKey(state.itemsRefreshedAt),
        controller: state.scrollController,
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          final item = state.items.elementAt(index);
          return ListTile(
            leading: const Icon(Icons.edit_road, size: 40),
            title: Text(item.name),
            subtitle: item.description.hasValue() ? Text(item.description.value) : null,
            onTap: () =>
                context.push('/tenant-admin/tracks/${item.id}?etag=${item.etag}', extra: state.refreshItemsCallback),
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
