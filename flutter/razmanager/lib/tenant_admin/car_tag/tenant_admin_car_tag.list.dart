import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/car_tag.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../refresh_model.dart';
import '../../utilities/crud_master_list_base.dart';

class TenantAdminCarTagList extends StatefulWidget {
  const TenantAdminCarTagList({super.key});

  @override
  State<TenantAdminCarTagList> createState() => _TenantAdminCarTagListState();
}

class _TenantAdminCarTagListState extends CrudMasterListStateBase<CarTagList, TenantAdminCarTagList> {
  _TenantAdminCarTagListState()
      : super(path: '/tenant-admin/car-tags', header: 'Car tags', body: _TenantAdminCarTagListBody());

  @override
  Future list(ListRequest listRequest) async {
    final client = CarTagServiceClient(clientChannel!, options: callOptionsFromContext(context));
    final response = await client.list(listRequest);
    return response.result;
  }
}

class _TenantAdminCarTagListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminCarTagListState>()!;
    return Consumer<RefreshModel>(builder: (context, model, child) {
      return ListView.separated(
        key: ObjectKey(state.itemsRefreshedAt),
        controller: state.scrollController,
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          final item = state.items.elementAt(index);
          return ListTile(
            title: Text(item.name),
            subtitle: item.description.hasValue() ? Text(item.description.value) : null,
            onTap: () =>
                context.push('/tenant-admin/car-tags/${item.id}?etag=${item.etag}', extra: state.refreshItemsCallback),
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
