import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../app_drawer.dart';
import '../../app_model.dart';
import '../../app_progress_indicator.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/tenant.pbgrpc.dart';
import '../../utilities/crud_master_detail_base.dart';
import '../../utilities/date_formatter.dart';
import '../../utilities/image_field.dart';
import '../../utilities/uppercase_textformatter.dart';

class TenantAdminTenantDetail extends CrudMasterDetailBase {
  const TenantAdminTenantDetail({super.key, required super.id});

  @override
  State createState() => _TenantAdminTenantState();
}

class _TenantAdminTenantState extends CrudMasterDetailStateBase<TenantRead> {
  _TenantAdminTenantState() : super(header: 'Club/Place', child: _TenantAdminTenantDetailBody(), shouldPop: false);

  final List<String> tenantInvitesDeleted = [];
  final List<String> tenantUsersDeleted = [];

  TenantServiceClient client() {
    return TenantServiceClient(clientChannel!, options: callOptionsFromContext(context));
  }

  @override
  Future<TenantRead> initialize() {
    return client().initialize(Empty());
  }

  @override
  Future read(id) async {
    final response = await client().read(IdRequest(id: id));
    return (response.entity, response.etag);
  }

  @override
  Future<void> save(id) async {
    List<TenantInviteReadCreateUpdate> tenantInvitesProto = [];
    final tenantInvitesFormArray = formGroup.control('tenantInvites') as FormArray;
    tenantInvitesFormArray.forEachChild((formGroup) {
      final fg = formGroup as FormGroup;
      if (fg.dirty) {
        tenantInvitesProto.add(TenantInviteReadCreateUpdate(
            id: fg.control('id').value,
            code: fg.control('code').value,
            multiple: fg.control('multiple').value,
            timeToLiveAt: Timestamp.fromDateTime(
              fg.control('timeToLiveAt').value,
            )));
      }
    });

    List<TenantUserReadCreateUpdate> tenantUsersProto = [];
    final tenantUsersFormArray = formGroup.control('tenantUsers') as FormArray;
    tenantUsersFormArray.forEachChild((formGroup) {
      final fg = formGroup as FormGroup;
      if (fg.dirty) {
        tenantUsersProto.add(TenantUserReadCreateUpdate(
          id: fg.control('id').value,
          userId: StringValue(value: fg.control('userId').value),
          name: StringValue(value: fg.control('name').value),
          shortName: StringValue(value: fg.control('shortName').value),
          administrator: fg.control('administrator').value,
        ));
      }
    });

    final proto = TenantCreateUpdate(
      name: formGroup.control('name').value,
      description: StringValue(value: formGroup.control('description').value),
      tenantInvites: tenantInvitesProto,
      tenantInvitesDeleted: tenantInvitesDeleted,
      tenantUsers: tenantUsersProto,
      tenantUsersDeleted: tenantUsersDeleted,
    );

    if (formGroup.control('image').dirty && formGroup.control('image').value != null) {
      proto.image = formGroup.control('image').value;
    }

    if (formGroup.control('imageDeleted').dirty && formGroup.control('imageDeleted').value == true) {
      proto.imageDeleted = formGroup.control('imageDeleted').value;
    }

    if (add) {
      final model = Provider.of<AppModel>(context, listen: false);
      final response = await client().create(proto);
      await model.tenantRefresh(response.id);
    } else {
      await client().update(TenantUpdateRequest(id: id, entity: proto, etag: etag));
    }
  }

  @override
  Future<void> delete(id) async {
    final model = Provider.of<AppModel>(context, listen: false);
    await client().delete(DeleteRequest(id: id, etag: etag));
    await model.tenantClear();
  }

  @override
  void onSaved() {
    context.go('/tenant-admin/events');
  }

  @override
  void onDeleted() {
    context.go('/');
  }

  @override
  Future<void> createFormGroup(readProto) async {
    formGroup = FormGroup({
      'name': FormControl<String?>(
          value: readProto.name.hasValue() ? readProto.name.value : null, validators: [Validators.required]),
      'description': FormControl<String?>(value: readProto.description.hasValue() ? readProto.description.value : null),
      'image':
          FormControl<Uint8List?>(value: readProto.image.hasValue() ? Uint8List.fromList(readProto.image.value) : null),
      'imageDeleted': FormControl<bool?>(),
      'tenantInvites': FormArray([]),
      'tenantUsers': FormArray([]),
    });

    final tenantInvitesArray = formGroup.control('tenantInvites') as FormArray;
    for (final tenantInvite in readProto.tenantInvites) {
      tenantInvitesArray.add(FormGroup({
        'id': FormControl<String>(value: tenantInvite.id),
        'code': FormControl<int>(value: tenantInvite.code),
        'multiple': FormControl<bool>(value: tenantInvite.multiple),
        'timeToLiveAt': FormControl<DateTime>(value: tenantInvite.timeToLiveAt.toDateTime(toLocal: true))
      }));
    }

    final tenantUsersArray = formGroup.control('tenantUsers') as FormArray;
    for (final tenantUser in readProto.tenantUsers) {
      tenantUsersArray.add(FormGroup({
        'id': FormControl<String>(value: tenantUser.id),
        'userId': FormControl<String?>(value: tenantUser.userId.hasValue() ? tenantUser.userId.value : null),
        'name': FormControl<String?>(
            value: tenantUser.name.hasValue() ? tenantUser.name.value : null, validators: [Validators.required]),
        'shortName': FormControl<String?>(
            value: tenantUser.shortName.hasValue() ? tenantUser.shortName.value : null,
            validators: [Validators.minLength(3)]),
        'administrator': FormControl<bool>(value: tenantUser.administrator),
      }));
    }
  }

  void tenantInviteAdd() {
    final tenantInvitesArray = formGroup.control('tenantInvites') as FormArray;
    final fg = FormGroup({
      'id': FormControl<String>(value: null),
      'code': FormControl<int>(value: (100000 + Random().nextInt(900000))),
      'multiple': FormControl<bool>(value: false),
      'timeToLiveAt': FormControl<DateTime>(value: DateTime.now().add(const Duration(days: 7)))
    });
    tenantInvitesArray.add(fg);
    fg.markAsDirty();
  }

  void tenantInviteDelete(FormGroup tenantInviteFormGroup) {
    final tenantInvitesArray = formGroup.control('tenantInvites') as FormArray;
    if (tenantInviteFormGroup.control('id').isNotNull) {
      tenantInvitesDeleted.add(tenantInviteFormGroup.control('id').value);
    }
    tenantInvitesArray.remove(tenantInviteFormGroup);
    formGroup.markAsDirty();
  }

  void tenantUserAdd() {
    final tenantUsersArray = formGroup.control('tenantUsers') as FormArray;
    final fg = FormGroup({
      'id': FormControl<String>(value: null),
      'userId': FormControl<String?>(value: null),
      'name': FormControl<String?>(value: null, validators: [Validators.required]),
      'shortName': FormControl<String?>(value: null, validators: [Validators.required, Validators.minLength(3)]),
      'administrator': FormControl<bool>(value: false),
    });
    tenantUsersArray.add(fg);
    fg.markAsDirty();
  }

  void tenantUserDelete(FormGroup tenantUserFormGroup) {
    final tenantUsersArray = formGroup.control('tenantUsers') as FormArray;
    if (tenantUserFormGroup.control('id').isNotNull) {
      tenantUsersDeleted.add(tenantUserFormGroup.control('id').value);
    }
    tenantUsersArray.remove(tenantUserFormGroup);
    formGroup.markAsDirty();
  }
}

class _TenantAdminTenantDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminTenantState>()!;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(state.header),
            flexibleSpace: const AppProgressIndicator(),
            bottom: TabBar(
                tabs: [Tab(text: state.header), const Tab(text: 'Invitation codes'), const Tab(text: 'Members')]),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth > 600) {
                      final formGroup = context.findAncestorStateOfType<_TenantAdminTenantState>()!.formGroup;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 2, child: _TenantAdminTenantDetailBodyMain()),
                          const SizedBox(width: 16),
                          Expanded(child: ImageField(formGroup: formGroup))
                        ],
                      );
                    } else {
                      final formGroup = context.findAncestorStateOfType<_TenantAdminTenantState>()!.formGroup;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TenantAdminTenantDetailBodyMain(),
                          const SizedBox(height: 16),
                          ImageField(formGroup: formGroup)
                        ],
                      );
                    }
                  }),
                ),
              ),
              Stack(children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) => _TenantAdminTenantInviteDetail(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:
                        IconButton.filledTonal(icon: const Icon(Icons.add), onPressed: () => state.tenantInviteAdd()),
                  ),
                )
              ]),
              Stack(children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) => _TenantAdminTenantUserDetail(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton.filledTonal(icon: const Icon(Icons.add), onPressed: () => state.tenantUserAdd()),
                  ),
                )
              ]),
            ],
          ),
          bottomNavigationBar: const ReactiveFormBottomAppBar(),
          drawer: const AppDrawer(),
        ));
  }
}

class _TenantAdminTenantDetailBodyMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: ReactiveTextField<String?>(
            formControlName: 'name',
            maxLength: 100,
            textCapitalization: TextCapitalization.sentences,
            validationMessages: {ValidationMessage.required: (error) => 'Please enter a name.'},
            decoration: const InputDecoration(
                labelText: "Name *", helperText: 'This name will be shown to those that can view your events'),
          ),
        ),
        ReactiveTextField<String?>(
          formControlName: 'description',
          maxLength: 1000,
          textCapitalization: TextCapitalization.sentences,
          minLines: 2,
          maxLines: 10,
          decoration: const InputDecoration(labelText: "Description"),
        ),
      ],
    );
  }
}

class _TenantAdminTenantInviteDetail extends StatelessWidget with DateFormatter {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminTenantState>()!;
    return ReactiveFormArray(
        formArrayName: 'tenantInvites',
        builder: (context, formArray, child) {
          final children = <Widget>[];
          children.add(tenantInviteRow(
              code: const Text('Code'), multiple: const Text('Multiple'), timeToLiveAt: const Text('Valid to')));
          formArray.forEachChild((formGroup) {
            final fg = formGroup as FormGroup;
            children.add(
              ReactiveForm(
                key: UniqueKey(),
                formGroup: fg,
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return tenantInviteRow(
                      code: SelectableText(fg.control('code').value.toString()),
                      multiple: ReactiveCheckboxListTile(formControlName: 'multiple'),
                      timeToLiveAt: Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.date_range),
                              onPressed: () async {
                                final result = await showDatePicker(
                                    context: context,
                                    initialDate: (fg.control('timeToLiveAt').value as DateTime).isBefore(DateTime.now())
                                        ? null
                                        : fg.control('timeToLiveAt').value,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(const Duration(days: 7)));
                                if (result != null) {
                                  setState(() {
                                    fg.control('timeToLiveAt').value = result;
                                    fg.control('timeToLiveAt').markAsDirty();
                                  });
                                }
                              }),
                          Text(dateTimeFormat(fg.control('timeToLiveAt').value as DateTime)),
                        ],
                      ),
                      delete: IconButton(icon: const Icon(Icons.delete), onPressed: () => state.tenantInviteDelete(fg)),
                    );
                  },
                ),
              ),
            );
          });
          return Column(children: children);
        });
  }

  Row tenantInviteRow({required Widget code, required Widget multiple, required Widget timeToLiveAt, Widget? delete}) {
    return Row(
      children: [
        SizedBox(width: 80, child: code),
        SizedBox(width: 80, child: multiple),
        SizedBox(width: 200, child: timeToLiveAt),
        const SizedBox(width: 16),
        if (delete != null) delete
      ],
    );
  }
}

class _TenantAdminTenantUserDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminTenantState>()!;
    return ReactiveFormArray(
        formArrayName: 'tenantUsers',
        builder: (context, formArray, child) {
          final children = <Widget>[];
          children.add(tenantUserRow(
              name: const Text('Name *'),
              shortName: const Text('Short name *'),
              administrator: const Text('Administrator')));
          formArray.forEachChild((formGroup) {
            final fg = formGroup as FormGroup;
            final hasUserId = fg.control('userId').value != null && (fg.control('userId').value as String).isNotEmpty;
            children.add(
              ReactiveForm(
                key: UniqueKey(),
                formGroup: fg,
                child: tenantUserRow(
                  name: hasUserId
                      ? Text(fg.control('name').value)
                      : ReactiveTextField(
                          formControlName: 'name',
                          maxLength: 100,
                          textCapitalization: TextCapitalization.sentences,
                          validationMessages: {ValidationMessage.required: (error) => 'Please enter a name.'},
                        ),
                  shortName: hasUserId
                      ? Text(fg.control('shortName').value ?? '')
                      : ReactiveTextField(
                          formControlName: 'shortName',
                          maxLength: 3,
                          inputFormatters: [UpperCaseTextFormatter()],
                          textCapitalization: TextCapitalization.characters,
                          validationMessages: {
                            ValidationMessage.required: (error) => 'Please enter a short name.',
                            ValidationMessage.minLength: (error) => 'Short name must be 3 characters long.'
                          },
                        ),
                  administrator: hasUserId ? ReactiveCheckboxListTile(formControlName: 'administrator') : null,
                  delete: IconButton(icon: const Icon(Icons.delete), onPressed: () => state.tenantUserDelete(fg)),
                ),
              ),
            );
          });
          return Column(children: children);
        });
  }

  Row tenantUserRow({required Widget name, required Widget shortName, Widget? administrator, Widget? delete}) {
    return Row(
      children: [
        SizedBox(width: 300, child: name),
        const SizedBox(width: 16),
        SizedBox(width: 100, child: shortName),
        const SizedBox(width: 16),
        SizedBox(width: 100, child: administrator),
        const SizedBox(width: 16),
        if (delete != null) delete
      ],
    );
  }
}
