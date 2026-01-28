import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../app_drawer.dart';
import '../../app_model.dart';
import '../../app_progress_indicator.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/user.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/user_services/event.pb.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/user_services/tenant.pb.dart';
import '../../utilities/crud_master_detail_base.dart';
import '../../utilities/image_field.dart';
import '../../utilities/uppercase_textformatter.dart';

class ProfileDetail extends CrudMasterDetailBase {
  const ProfileDetail({super.key}) : super(id: '');

  @override
  State createState() => _ProfileDetailState();
}

class _ProfileDetailState extends CrudMasterDetailStateBase<UserRead> {
  _ProfileDetailState() : super(header: 'Profile', child: _ProfileDetailBody(), shouldPop: false);

  final List<String> eventsDeleted = [];
  final List<String> tenantsDeleted = [];

  UserServiceClient client() {
    return UserServiceClient(clientChannel!, options: callOptionsFromContext(context));
  }

  @override
  Future<UserRead> initialize() {
    return Future.value(UserRead());
  }

  @override
  Future read(id) async {
    final response = await client().read(Empty());
    return (response.entity, response.etag);
  }

  @override
  Future<void> save(id) async {
    final proto = UserUpdate(
      email: StringValue(value: formGroup.control('email').value),
      name: formGroup.control('name').value,
      shortName: formGroup.control('shortName').value,
      eventsDeleted: eventsDeleted,
      tenantsDeleted: tenantsDeleted,
    );

    if (formGroup.control('image').dirty && formGroup.control('image').value != null) {
      proto.image = formGroup.control('image').value;
    }

    if (formGroup.control('imageDeleted').dirty && formGroup.control('imageDeleted').value == true) {
      proto.imageDeleted = formGroup.control('imageDeleted').value;
    }

    await client().update(UserUpdateRequest(entity: proto, etag: etag));
  }

  @override
  Future<void> delete(id) async {
    final model = Provider.of<AppModel>(context, listen: false);
    await client().delete(EtagRequest(etag: etag));
    await model.tokenClear();
  }

  @override
  void onSaved() {
    context.go('/');
  }

  @override
  void onDeleted() {
    context.go('/');
  }

  @override
  Future<void> createFormGroup(readProto) async {
    formGroup = FormGroup({
      'email': FormControl<String>(value: readProto.email.hasValue() ? readProto.email.value : null, validators: [Validators.email]),
      'name': FormControl<String>(value: readProto.name.value, validators: [Validators.required]),
      'shortName': FormControl<String>(value: readProto.shortName.value,          validators: [Validators.required, Validators.minLength(3)]),
      'image':
          FormControl<Uint8List?>(value: readProto.image.hasValue() ? Uint8List.fromList(readProto.image.value) : null),
      'imageDeleted': FormControl<bool?>()
    });
  }

  void eventDelete(EventSelect value) {
    readProto.events.remove(value);
    eventsDeleted.add(value.id);
    formGroup.markAsDirty();
  }

  void tenantDelete(TenantSelect value) {
    readProto.tenants.remove(value);
    tenantsDeleted.add(value.id);
    formGroup.markAsDirty();
  }
}

class _ProfileDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_ProfileDetailState>()!;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(state.header),
            flexibleSpace: const AppProgressIndicator(),
            bottom: TabBar(tabs: [Tab(text: state.header), const Tab(text: 'Events'), const Tab(text: 'Clubs/Places')]),
          ),
          body: TabBarView(children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth > 600) {
                    final formGroup = context.findAncestorStateOfType<_ProfileDetailState>()!.formGroup;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: _ProfileDetailBodyMain()),
                        const SizedBox(width: 16),
                        Expanded(child: ImageField(formGroup: formGroup))
                      ],
                    );
                  } else {
                    final formGroup = context.findAncestorStateOfType<_ProfileDetailState>()!.formGroup;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ProfileDetailBodyMain(),
                        const SizedBox(height: 16),
                        ImageField(formGroup: formGroup)
                      ],
                    );
                  }
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _ProfileDetailEvents(),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _ProfileDetailTenants(),
            ),
          ]),
          bottomNavigationBar: const ReactiveFormBottomAppBar(),
          drawer: const AppDrawer(),
        ));
  }
}

class _ProfileDetailBodyMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: ReactiveTextField(
            formControlName: 'email',
            maxLength: 100,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'E-mail',
            ),
            validationMessages: {
              ValidationMessage.email: (error) => 'Please enter a valid e-mail address.'
            },
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: ReactiveTextField(
            formControlName: 'name',
            maxLength: 100,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Name *',
            ),
            validationMessages: {ValidationMessage.required: (error) => 'Please enter a name.'},
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100),
          child: ReactiveTextField(
            formControlName: 'shortName',
            maxLength: 3,
            inputFormatters: [UpperCaseTextFormatter()],
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(
              labelText: 'Short name *',
            ),
            validationMessages: {ValidationMessage.minLength: (error) => 'Short name must be 3 characters long.'},
          ),
        ),
      ],
    );
  }
}

class _ProfileDetailEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_ProfileDetailState>()!;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        if (state.readProto.events.isEmpty) {
          return const Text("You're currently not a part of any event.");
        } else {
          return ListView.separated(
            itemCount: state.readProto.events.length,
            itemBuilder: (context, index) {
              final item = state.readProto.events.elementAt(index);
              return ListTile(
                leading: item.image.hasValue()
                    ? CircleAvatar(foregroundImage: MemoryImage(Uint8List.fromList(item.image.value)))
                    : item.tenant.image.hasValue()
                        ? CircleAvatar(foregroundImage: MemoryImage(Uint8List.fromList(item.tenant.image.value)))
                        : const Icon(
                            Icons.event,
                            size: 40,
                          ),
                title: Text(item.name),
                subtitle: Text(item.tenant.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: item.tenant.administrator ? null : () => setState(() => state.eventDelete(item)),
                  tooltip: 'Leave this event',
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        }
      },
    );
  }
}

class _ProfileDetailTenants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_ProfileDetailState>()!;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        if (state.readProto.tenants.isEmpty) {
          return const Text("You're currently not a part of any club/place.");
        } else {
          return ListView.separated(
            itemCount: state.readProto.tenants.length,
            itemBuilder: (context, index) {
              final item = state.readProto.tenants.elementAt(index);
              return ListTile(
                leading: item.image.hasValue()
                    ? CircleAvatar(foregroundImage: MemoryImage(Uint8List.fromList(item.image.value)))
                    : const Icon(
                        Icons.place,
                        size: 40,
                      ),
                title: Text(item.name),
                subtitle: item.administrator ? const Text('Administrator') : null,
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: item.administrator ? null : () => setState(() => state.tenantDelete(item)),
                  tooltip: 'Leave this club/place',
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        }
      },
    );
  }
}
