import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/car.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/car_tag.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../refresh_model.dart';
import '../../utilities/crud_master_list_base.dart';

class TenantAdminCarList extends StatefulWidget {
  const TenantAdminCarList({super.key});

  @override
  State<TenantAdminCarList> createState() => _TenantAdminCarListState();
}

class _TenantAdminCarListState extends CrudMasterListStateBase<CarList, TenantAdminCarList> {
  _TenantAdminCarListState() : super(path: '/tenant-admin/cars', header: 'Cars', body: _TenantAdminCarListBody());

  late Iterable<CarTagSelect> carTags;
  Set<String> carTagFilters = {};

  @override
  Future<void> initialize() async {
    final client = CarTagServiceClient(clientChannel!, options: callOptionsFromContext(context));
    final carTagsSelectReponse = await client.select(Empty());
    carTags = carTagsSelectReponse.result;
  }

  @override
  Future list(ListRequest listRequest) async {
    final client = CarServiceClient(clientChannel!, options: callOptionsFromContext(context));
    final response = await client
        .list(CarListRequest(limit: listRequest.limit, offset: listRequest.offset, carTagIds: carTagFilters));
    return response.result;
  }
}

class _TenantAdminCarListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminCarListState>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.carTags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
              return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: state.carTags
                      .map((e) => InputChip(
                            label: Text(e.name),
                            selected: state.carTagFilters.contains(e.id),
                            onSelected: (value) async {
                              setState(() {
                                if (value) {
                                  state.carTagFilters.add(e.id);
                                } else {
                                  state.carTagFilters.remove(e.id);
                                }
                              });

                              final refreshModel = context.read<RefreshModel>();
                              await state.refreshItems(notify: true);
                              refreshModel.refreshed();
                            },
                          ))
                      .toList());
            }),
          ),
        Consumer<RefreshModel>(
          builder: (context, model, child) {
            return Expanded(
              child: ListView.separated(
                key: ObjectKey(state.itemsRefreshedAt),
                controller: state.scrollController,
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items.elementAt(index);
                  return ListTile(
                    leading: item.image.hasValue()
                        ? CircleAvatar(foregroundImage: MemoryImage(Uint8List.fromList(item.image.value)))
                        : const Icon(
                            Icons.drive_eta,
                            size: 40,
                          ),
                    title: Text(item.name),
                    subtitle: item.carTagNames.isNotEmpty ? Text(item.carTagNames) : null,
                    onTap: () => context.push('/tenant-admin/cars/${item.id}?etag=${item.etag}',
                        extra: state.refreshItemsCallback),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Divider(),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
