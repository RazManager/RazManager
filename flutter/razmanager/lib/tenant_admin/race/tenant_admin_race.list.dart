import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/race.pbgrpc.dart';
import '../../refresh_model.dart';
import '../../utilities/crud_master_list_base.dart';

class TenantAdminRaceList extends StatefulWidget {
  const TenantAdminRaceList({super.key});

  @override
  State<TenantAdminRaceList> createState() => _TenantAdminRaceListState();
}

class _TenantAdminRaceListState extends CrudMasterListStateBase<RaceList, TenantAdminRaceList> {
  _TenantAdminRaceListState()
      : super(path: '/tenant-admin/races', header: 'Races', body: _TenantAdminRaceListBody());

  @override
  Future list(ListRequest listRequest) async {
    final client = RaceServiceClient(clientChannel!, options: callOptionsFromContext(context));
    final response = await client.list(listRequest);
    return response.result;
  }
}

class _TenantAdminRaceListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminRaceListState>()!;
    return Consumer<RefreshModel>(builder: (context, model, child) {
      return ListView.separated(
        key: ObjectKey(state.itemsRefreshedAt),
        controller: state.scrollController,
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          final item = state.items.elementAt(index);
          return ListTile(
            title: Text("${item.event.name} - ${item.number.toString()}${item.name.hasValue() ? ' - ${item.name.value}' : ''}"),
            subtitle: Text(item.raceStateType.name),
            onTap: () =>
                context.push('/tenant-admin/races/${item.id}?etag=${item.etag}', extra: state.refreshItemsCallback),
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
