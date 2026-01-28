import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../app_model.dart';
import '../../app_progress_indicator.dart';
import '../../protobuf/razmanager/protobuf/public/event_user_type_id.v1.pbenum.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/event.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/tenant_user.pbgrpc.dart';
import '../../utilities/crud_master_detail_base.dart';
import '../../utilities/date_formatter.dart';
import '../../utilities/date_time_field.dart';
import '../../utilities/image_avatar_field.dart';
import '../../utilities/image_field.dart';
import '../../utilities/uppercase_textformatter.dart';
import '../../utilities/color_definition_field.dart';

class TenantAdminEventDetail extends CrudMasterDetailBase {
  const TenantAdminEventDetail({super.key, required super.id, required super.oldEtag, required super.refreshItems});

  @override
  State createState() => _TenantAdminEventState();
}

class _TenantAdminEventState extends CrudMasterDetailStateBase<EventRead> {
  _TenantAdminEventState() : super(header: 'Event', child: _TenantAdminEventDetailBody());
  final List<String> eventInvitesDeleted = [];
  final List<String> eventUsersDeleted = [];

  EventServiceClient client() {
    return EventServiceClient(clientChannel!, options: callOptionsFromContext(context));
  }

  TenantUserServiceClient tenantUserClient() {
    return TenantUserServiceClient(clientChannel!, options: callOptionsFromContext(context));
  }

  @override
  Future<EventRead> initialize() {
    return client().initialize(Empty());
  }

  @override
  Future read(id) async {
    final response = await client().read(IdRequest(id: id));
    return (response.entity, response.etag);
  }

  @override
  Future<void> save(id) async {
    List<EventInviteReadCreateUpdate> eventInvitesProto = [];
    final eventInvitesFormArray = formGroup.control('eventInvites') as FormArray;
    eventInvitesFormArray.forEachChild((formGroup) {
      final fg = formGroup as FormGroup;
      if (fg.dirty) {
        eventInvitesProto.add(EventInviteReadCreateUpdate(
            id: fg.control('id').value,
            code: fg.control('code').value,
            multiple: fg.control('multiple').value,
            timeToLiveAt: Timestamp.fromDateTime(
              fg.control('timeToLiveAt').value,
            )));
      }
    });

    List<EventUserCreateUpdate> eventUsersProto = [];
    final eventUsersFormArray = formGroup.control('eventUsers') as FormArray;
    eventUsersFormArray.forEachChild((formGroup) {
      final fg = formGroup as FormGroup;
      if (fg.dirty) {
        final eventUserProto = EventUserCreateUpdate(
          id: fg.control('id').value,
          userId: StringValue(value: fg.control('userId').value),
          name: StringValue(value: fg.control('name').value),
          shortName: StringValue(value: fg.control('shortName').value),
          eventUserTypeId: fg.control('eventUserTypeId').value,
          eventUserId: StringValue(value: fg.control('eventUserId').value),
        );

        if (fg.control('image').dirty && fg.control('image').value != null) {
          eventUserProto.image = fg.control('image').value;
        }

        if (fg.control('imageDeleted').dirty && fg.control('imageDeleted').value == true) {
          eventUserProto.imageDeleted = formGroup.control('imageDeleted').value;
        }

        eventUsersProto.add(eventUserProto);
      }
    });

    final proto = EventCreateUpdate(
      name: formGroup.control('name').value,
      description: StringValue(value: formGroup.control('description').value),
      startsAt: formGroup.control('startsAt').value != null ? Timestamp.fromDateTime(formGroup.control('startsAt').value) : null,
      publishFrom: formGroup.control('publishFrom').value != null ? Timestamp.fromDateTime(formGroup.control('publishFrom').value) : null,
      publishUntil: Timestamp.fromDateTime(formGroup.control('publishUntil').value),
      eventVisibilityTypeId: formGroup.control('eventVisibilityTypeId').value,
      eventInvites: eventInvitesProto,
      eventInvitesDeleted: eventInvitesDeleted,
      eventUsers: eventUsersProto,
      eventUsersDeleted: eventUsersDeleted,
    );

    if (formGroup.control('image').dirty && formGroup.control('image').value != null) {
      proto.image = formGroup.control('image').value;
    }

    if (formGroup.control('imageDeleted').dirty && formGroup.control('imageDeleted').value == true) {
      proto.imageDeleted = formGroup.control('imageDeleted').value;
    }

    if (add) {
      await client().create(proto);
    } else {
      await client().update(EventUpdateRequest(id: id, entity: proto, etag: etag));
    }
  }

  @override
  Future<void> delete(id) async {
    await client().delete(DeleteRequest(id: id, etag: etag));
  }

  @override
  Future<void> createFormGroup(readProto) async {
    formGroup = FormGroup({
      'name': FormControl<String?>(value: readProto.name.hasValue() ? readProto.name.value : null, validators: [Validators.required]),
      'description': FormControl<String?>(value: readProto.description.hasValue() ? readProto.description.value : null),
      'startsAt': FormControl<DateTime?>(value: readProto.startsAt.hasSeconds() ? readProto.startsAt.toDateTime(toLocal: true) : null),
      'publishFrom': FormControl<DateTime?>(value: readProto.publishFrom.hasSeconds() ? readProto.publishFrom.toDateTime(toLocal: true) : null),
      'publishUntil': FormControl<DateTime>(value: readProto.publishUntil.toDateTime(toLocal: true), validators: [Validators.required]),
      'eventVisibilityTypeId': FormControl<EventVisibilityTypeId>(
          value: readProto.eventVisibilityTypeId != EventVisibilityTypeId.EVENT_VISIBILITY_TYPE_ID_UNDEFINED ? readProto.eventVisibilityTypeId : null,
          validators: [Validators.required]),
      'image': FormControl<Uint8List?>(value: readProto.image.hasValue() ? Uint8List.fromList(readProto.image.value) : null),
      'imageDeleted': FormControl<bool?>(),
      'eventInvites': FormArray([]),
      'eventUsers': FormArray([]),
    });

    final eventInvitesArray = formGroup.control('eventInvites') as FormArray;
    for (final eventInvite in readProto.eventInvites) {
      eventInvitesArray.add(FormGroup({
        'id': FormControl<String>(value: eventInvite.id),
        'code': FormControl<int>(value: eventInvite.code),
        'multiple': FormControl<bool>(value: eventInvite.multiple),
        'timeToLiveAt': FormControl<DateTime>(value: eventInvite.timeToLiveAt.toDateTime(toLocal: true))
      }));
    }

    final eventUsersArray = formGroup.control('eventUsers') as FormArray;
    for (final eventUser in readProto.eventUsers) {
debugPrint("id=${eventUser.id} eventUserId=${eventUser.eventUserId} userId=${eventUser.userId} name=${eventUser.name} shortName=${eventUser.shortName} eventUserTypeId=${eventUser.eventUserTypeId}");
      eventUsersArray.add(FormGroup({
        'id': FormControl<String>(value: eventUser.id),
        'userId': FormControl<String?>(value: eventUser.userId.hasValue() ? eventUser.userId.value : null),
        'name': FormControl<String?>(value: eventUser.name.hasValue() ? eventUser.name.value : null, validators: [Validators.required]),
        'shortName': FormControl<String?>(value: eventUser.shortName.hasValue() ? eventUser.shortName.value : null, validators: [Validators.minLength(3)]),
        'eventUserTypeId':
            FormControl<EventUserTypeId?>(value: eventUser.eventUserTypeId == EventUserTypeId.EVENT_USER_TYPE_ID_UNDEFINED ? null : eventUser.eventUserTypeId),
        'eventUserId': FormControl<String?>(value: eventUser.eventUserId.hasValue() ? eventUser.eventUserId.value : null),
        'image': FormControl<Uint8List?>(value: eventUser.image.hasValue() ? Uint8List.fromList(eventUser.image.value) : null),
        'imageDeleted': FormControl<bool?>(),
      }));
    }
  }

  void eventInviteAdd() {
    final eventInvitesArray = formGroup.control('eventInvites') as FormArray;
    final fg = FormGroup({
      'id': FormControl<String>(value: null),
      'code': FormControl<int>(value: (100000 + Random().nextInt(900000))),
      'multiple': FormControl<bool>(value: false),
      'timeToLiveAt': FormControl<DateTime>(value: DateTime.now().add(const Duration(days: 30)))
    });
    eventInvitesArray.add(fg);
    fg.markAsDirty();
  }

  void eventInviteDelete(FormGroup eventInviteFormGroup) {
    final eventInvitesArray = formGroup.control('eventInvites') as FormArray;
    if (eventInviteFormGroup.control('id').isNotNull) {
      eventInvitesDeleted.add(eventInviteFormGroup.control('id').value);
    }
    eventInvitesArray.remove(eventInviteFormGroup);
    formGroup.markAsDirty();
  }

  void eventUserAdd() {
    final eventUsersArray = formGroup.control('eventUsers') as FormArray;
    final fg = FormGroup({
      'id': FormControl<String>(value: Uuid().v4()),
      'userId': FormControl<String?>(value: null),
      'name': FormControl<String?>(value: null, validators: [Validators.required]),
      'shortName': FormControl<String?>(value: null, validators: [Validators.required, Validators.minLength(3)]),
      'eventUserTypeId': FormControl<EventUserTypeId?>(value: EventUserTypeId.EVENT_USER_TYPE_ID_DRIVER),
      'eventUserId': FormControl<String?>(value: null),
      'image': FormControl<Uint8List?>(value: null),
      'imageDeleted': FormControl<bool?>(),
    });
    eventUsersArray.add(fg);
    fg.markAsDirty();
  }

  void eventUserDelete(FormGroup eventUserFormGroup) {
    final eventUsersArray = formGroup.control('eventUsers') as FormArray;
    if (eventUserFormGroup.control('id').isNotNull) {
      eventUsersDeleted.add(eventUserFormGroup.control('id').value);
    }
    eventUsersArray.remove(eventUserFormGroup);
    formGroup.markAsDirty();
  }

  Future<void> tenantUserAdd() async {
    final request = TenantUserSelectRequest();

    final eventUsersFormArray = formGroup.control('eventUsers') as FormArray;
    eventUsersFormArray.forEachChild((formGroup) {
      final fg = formGroup as FormGroup;
      if (fg.control('userId').value != null) {
        request.userIdsExclude.add(fg.control('userId').value);
      } else {
        request.shortNamesExclude.add(fg.control('shortName').value);
      }
    });

    List<TenantUserSelect> items = [];
    final model = context.read<AppModel>();
    model.setBusy(value: true, notify: true);
    clientChannel = createClientChannel();
    try {
      final response = await tenantUserClient().select(request);
      items = response.result;
    } on Exception catch (exception) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exceptionMessage(exception)), duration: const Duration(seconds: 10)));
    } finally {
      if (clientChannel != null) {
        await clientChannel!.shutdown();
      }
      model.setBusy(value: false, notify: true);
    }

    if (items.isEmpty) {}

    if (!context.mounted) {
      return;
    }

    final result = await showDialog<List<TenantUserSelect>?>(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          final result = <TenantUserSelect>[];
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: const Text('Select members that will join the event'),
                content: SizedBox(
                  width: 100,
                  height: 300,
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        value: result.contains(items[index]),
                        title: Text(items[index].name, overflow: TextOverflow.ellipsis),
                        subtitle: Text(items[index].shortName.value),
                        secondary: const Icon(Icons.person),
                        onChanged: (value) => setState(() {
                          if (value != null && value) {
                            result.add(items[index]);
                          } else {
                            result.remove(items[index]);
                          }
                        }),
                      );
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(null);
                    },
                  ),
                  TextButton(
                    onPressed: result.isEmpty
                        ? null
                        : () {
                            Navigator.of(context).pop(result);
                          },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        });
    if (result != null) {
      final eventUsersArray = formGroup.control('eventUsers') as FormArray;
      for (final tenantUser in result) {
        final fg = FormGroup({
          'id': FormControl<String>(value: null),
          'userId': FormControl<String?>(value: tenantUser.userId.hasValue() ? tenantUser.userId.value : null),
          'name': FormControl<String?>(value: tenantUser.name),
          'shortName': FormControl<String?>(value: tenantUser.shortName.hasValue() ? tenantUser.shortName.value : null),
          'eventUserTypeId': FormControl<EventUserTypeId?>(value: EventUserTypeId.EVENT_USER_TYPE_ID_DRIVER),
          'eventUserId': FormControl<String?>(value: null),
          'image': FormControl<Uint8List?>(value: null),
          'imageDeleted': FormControl<bool?>(),
        });
        eventUsersArray.add(fg);
        fg.markAsDirty();
      }
    }
  }
}

class _TenantAdminEventDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminEventState>()!;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(state.header),
            flexibleSpace: const AppProgressIndicator(),
            bottom: TabBar(tabs: [Tab(text: state.header), const Tab(text: 'Invitation codes'), const Tab(text: 'Participants')]),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth > 600) {
                      final formGroup = context.findAncestorStateOfType<_TenantAdminEventState>()!.formGroup;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 2, child: _TenantAdminEventDetailBodyMain()),
                          const SizedBox(width: 16),
                          Expanded(child: ImageField(formGroup: formGroup))
                        ],
                      );
                    } else {
                      final formGroup = context.findAncestorStateOfType<_TenantAdminEventState>()!.formGroup;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [_TenantAdminEventDetailBodyMain(), const SizedBox(height: 16), ImageField(formGroup: formGroup)],
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
                      builder: (BuildContext context, BoxConstraints constraints) => _TenantAdminEventInviteDetail(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton.filledTonal(icon: const Icon(Icons.add), onPressed: state.eventInviteAdd),
                  ),
                )
              ]),
              Stack(children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) => _TenantAdminEventUserDetail(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FilledButton.tonalIcon(icon: const Icon(Icons.add), label: const Text('Add a guest'), onPressed: state.eventUserAdd),
                        const SizedBox(height: 16),
                        FilledButton.tonalIcon(
                            icon: const Icon(Icons.add), label: const Text('Add member(s)'), onPressed: () async => await state.tenantUserAdd()),
                        const SizedBox(height: 16),
                        FilledButton.tonalIcon(icon: const Icon(Icons.add), label: const Text('Add autopilot(s)'), onPressed: state.eventUserAdd),
                      ],
                    ),
                  ),
                )
              ]),
            ],
          ),
          bottomNavigationBar: const ReactiveFormBottomAppBar(),
        ));
  }
}

class _TenantAdminEventDetailBodyMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminEventState>()!;
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
            decoration: const InputDecoration(labelText: "Name *", helperText: 'This name will be shown to those that can view your events'),
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
        Row(
          children: [
            Expanded(
              child: DateTimeField(
                formGroup: state.formGroup,
                formControlName: 'startsAt',
                labelText: 'Starts at',
                duration: const Duration(days: 89),
                required: false,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DateTimeField(
                formGroup: state.formGroup,
                formControlName: 'publishFrom',
                duration: const Duration(days: 89),
                labelText: 'Publish from',
                required: false,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DateTimeField(
                formGroup: state.formGroup,
                formControlName: 'publishUntil',
                labelText: 'Publish until *',
                duration: const Duration(days: 90),
                required: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text('Visible to *', style: Theme.of(context).textTheme.bodyLarge),
        ReactiveRadioListTile<EventVisibilityTypeId>(
            formControlName: "eventVisibilityTypeId",
            value: EventVisibilityTypeId.EVENT_VISIBILITY_TYPE_ID_MEMBERS_AND_GUESTS,
            title: const Text("Members and guests")),
        ReactiveRadioListTile<EventVisibilityTypeId>(
            formControlName: "eventVisibilityTypeId", value: EventVisibilityTypeId.EVENT_VISIBILITY_TYPE_ID_PUBLIC, title: const Text("Public")),
      ],
    );
  }
}

class _TenantAdminEventInviteDetail extends StatelessWidget with DateFormatter {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminEventState>()!;
    return ReactiveFormArray(
        formArrayName: 'eventInvites',
        builder: (context, formArray, child) {
          final children = <Widget>[];
          children.add(eventInviteRow(code: const Text('Code'), multiple: const Text('Multiple'), timeToLiveAt: const Text('Valid to')));
          formArray.forEachChild((formGroup) {
            final fg = formGroup as FormGroup;
            children.add(
              ReactiveForm(
                key: UniqueKey(),
                formGroup: fg,
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return eventInviteRow(
                      code: SelectableText(fg.control('code').value.toString()),
                      multiple: ReactiveCheckbox(formControlName: 'multiple',),
                      timeToLiveAt: Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.date_range),
                              onPressed: () async {
                                final result = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        (fg.control('timeToLiveAt').value as DateTime).isBefore(DateTime.now()) ? null : fg.control('timeToLiveAt').value,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(const Duration(days: 30)));
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
                      delete: IconButton(icon: const Icon(Icons.delete), onPressed: () => state.eventInviteDelete(fg)),
                    );
                  },
                ),
              ),
            );
          });
          return Column(children: children);
        });
  }

  Row eventInviteRow({required Widget code, required Widget multiple, required Widget timeToLiveAt, Widget? delete}) {
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

class _TenantAdminEventUserDetail extends StatelessWidget {
  Future<Uint8List?> _pickImage(BuildContext context, FormGroup formGroup) {
    return showDialog<Uint8List?>(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Select an image'),
              content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                final picker = ImagePicker();
                return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
                      child: (formGroup.control('image').value != null) ? Image.memory(formGroup.control('image').value) : Placeholder()),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      FilledButton.tonal(
                          child: const Text('Select image'),
                          onPressed: () async {
                            final xFile = await picker.pickImage(source: ImageSource.gallery);
                            if (xFile != null) {
                              formGroup.control('image').value = await xFile.readAsBytes();
                              setState(() {
                                formGroup.control('image').markAsDirty();
                                formGroup.control('imageDeleted').value = false;
                              });
                            }
                          }),
                      if (picker.supportsImageSource(ImageSource.camera)) ...[
                        const SizedBox(width: 16),
                        FilledButton.tonal(
                            child: const Text('Take photo'),
                            onPressed: () async {
                              final xFile = await picker.pickImage(source: ImageSource.camera);
                              if (xFile != null) {
                                formGroup.control('image').value = await xFile.readAsBytes();
                                setState(() {
                                  formGroup.control('image').markAsDirty();
                                  formGroup.control('imageDeleted').value = false;
                                });
                              }
                            }),
                      ],
                      const SizedBox(width: 16),
                      FilledButton.tonal(
                        onPressed: formGroup.control('image').value != null
                            ? () {
                                setState(() {
                                  formGroup.control('image').value = null;
                                  formGroup.control('imageDeleted').value = true;
                                  formGroup.control('imageDeleted').markAsDirty();
                                });
                              }
                            : null,
                        child: const Text('Delete image'),
                      ),
                    ],
                  ),
                ]);
              }));
        });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminEventState>()!;

    return ReactiveFormArray(
        formArrayName: 'eventUsers',
        builder: (context, formArray, child) {
          List<EventUserSelect> teams = [];

          formArray.forEachChild((formGroup) {
            final fg = formGroup as FormGroup;
            if (fg.control('eventUserTypeId').value == EventUserTypeId.EVENT_USER_TYPE_ID_TEAM) {
              teams.add(EventUserSelect(id: fg.control('id').value, name: fg.control('name').value));
            }
          });

          final children = <Widget>[];
          children.add(eventUserRow(
              name: const Text('Name *'),
              shortName: const Text('Short name *'),
              eventUserTypeId: const Text('Team/Driver/Viewer *'),
              eventUserId: const Text('Team')));
          formArray.forEachChild((formGroup) {
            final fg = formGroup as FormGroup;
            //final hasUserId = fg.control('userId').value != null && (fg.control('userId').value as String).isNotEmpty;
            final hasUserId = false;
            children.add(
              ReactiveForm(
                key: UniqueKey(),
                formGroup: fg,
                child: eventUserRow(
                  name: hasUserId
                      ? Text(fg.control('name').value)
                      : ReactiveTextField<String?>(
                          formControlName: 'name',
                          maxLength: 100,
                          textCapitalization: TextCapitalization.words,
                          validationMessages: {ValidationMessage.required: (error) => 'Please enter a name.'},
                        ),
                  shortName: hasUserId
                      ? Text(fg.control('shortName').value ?? '')
                      : ReactiveTextField<String?>(
                          formControlName: 'shortName',
                          maxLength: 3,
                          inputFormatters: [UpperCaseTextFormatter()],
                          textCapitalization: TextCapitalization.characters,
                          validationMessages: {
                            ValidationMessage.required: (error) => 'Please enter a short name.',
                            ValidationMessage.minLength: (error) => 'Short name must be 3 characters long.'
                          },
                        ),
                  eventUserTypeId: hasUserId
                      ? ReactiveDropdownField<EventUserTypeId?>(
                          formControlName: 'eventUserTypeId',
                          items: const [
                            DropdownMenuItem(
                              value: EventUserTypeId.EVENT_USER_TYPE_ID_DRIVER,
                              child: Text('Driver'),
                            ),
                            DropdownMenuItem(
                              value: EventUserTypeId.EVENT_USER_TYPE_ID_VIEWER,
                              child: Text('Viewer'),
                            )
                          ],
                        )
                      : ReactiveDropdownField<EventUserTypeId?>(
                          formControlName: 'eventUserTypeId',
                          items: const [
                            DropdownMenuItem(
                              value: EventUserTypeId.EVENT_USER_TYPE_ID_TEAM,
                              child: Text('Team'),
                            ),
                            DropdownMenuItem(
                              value: EventUserTypeId.EVENT_USER_TYPE_ID_DRIVER,
                              child: Text('Driver'),
                            ),
                          ],
                        ),
                  eventUserId: fg.control('eventUserTypeId').value == EventUserTypeId.EVENT_USER_TYPE_ID_TEAM
                      ? null
                      : ReactiveDropdownField<String?>(
                          formControlName: 'eventUserId',
                          items: [DropdownMenuItem(value: null, child: Text('')), ...teams.map((x) => DropdownMenuItem(value: x.id, child: Text(x.name)))]),
                  image: fg.control('eventUserTypeId').value == EventUserTypeId.EVENT_USER_TYPE_ID_VIEWER
                      ? null
                      : ImageAvatarField(formGroup: fg, pickImage: _pickImage),
                  delete: IconButton(icon: const Icon(Icons.delete), onPressed: () => state.eventUserDelete(fg)),
                ),
              ),
            );
          });
          return Column(children: children);
        });
  }

  Row eventUserRow(
      {required Widget name, required Widget shortName, Widget? eventUserTypeId, Widget? eventUserId, Widget? color, Widget? image, Widget? delete}) {
    return Row(
      children: [
        SizedBox(width: 300, child: name),
        const SizedBox(width: 16),
        SizedBox(width: 100, child: shortName),
        const SizedBox(width: 16),
        SizedBox(width: 100, child: eventUserTypeId),
        const SizedBox(width: 16),
        if (eventUserId != null) ...[
          SizedBox(width: 300, child: eventUserId),
          const SizedBox(width: 16),
        ],
        if (color != null) ...[
          SizedBox(width: 250, child: color),
          const SizedBox(width: 16),
        ],
        if (image != null) ...[
          SizedBox(width: 150, child: image),
          const SizedBox(width: 16),
        ],
        if (delete != null) delete
      ],
    );
  }
}
