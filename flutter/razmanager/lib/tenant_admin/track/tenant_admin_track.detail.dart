import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../app_progress_indicator.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/device_configuration.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/race_format_type.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/track.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/track_configuration.pbgrpc.dart';
import '../../utilities/color_definition_field.dart';
import '../../utilities/crud_master_detail_base.dart';

class TenantAdminTrackDetail extends CrudMasterDetailBase {
  const TenantAdminTrackDetail(
      {super.key,
      required super.id,
      required super.oldEtag,
      required super.refreshItems});

  @override
  State createState() => _TenantAdminTrackDetailState();
}

class _TenantAdminTrackDetailState extends CrudMasterDetailStateBase<TrackRead> {
  _TenantAdminTrackDetailState()
      : super(header: 'Track', child: _TenantAdminTrackDetailBody());

  late Iterable<DeviceConfigurationSelect> deviceConfigurations;
  late Iterable<RaceFormatTypeSelect> raceFormatTypes;
  late TrackConfigurationReadCreateUpdate trackConfigurationInitialize;
  bool tabBarAdded = false;

  TrackServiceClient client() {
    return TrackServiceClient(clientChannel!, options: callOptionsFromContext(context));
  }

  @override
  Future<TrackRead> initialize() async {
    final futures = <Future>[];
    futures.add(client().initialize(Empty()));
    futures.add(DeviceConfigurationServiceClient(clientChannel!,
            options: callOptionsFromContext(context))
        .select(Empty()));
    futures.add(RaceFormatTypeServiceClient(clientChannel!,
            options: callOptionsFromContext(context))
        .select(Empty()));
    futures.add(TrackConfigurationServiceClient(clientChannel!,
            options: callOptionsFromContext(context))
        .initialize(Empty()));
    var response = await Future.wait(futures);
    deviceConfigurations =
        (response[1] as DeviceConfigurationSelectResponse).result;
    raceFormatTypes = (response[2] as RaceFormatTypeSelectResponse).result;
    trackConfigurationInitialize = response[3];

    return (response[0] as TrackRead);
  }

  @override
  Future read(id) async {
    final futures = <Future>[];
    futures.add(client().read(IdRequest(id: id)));
    futures.add(DeviceConfigurationServiceClient(clientChannel!,
            options: callOptionsFromContext(context))
        .select(Empty()));
    futures.add(RaceFormatTypeServiceClient(clientChannel!,
            options: callOptionsFromContext(context))
        .select(Empty()));
    futures.add(TrackConfigurationServiceClient(clientChannel!,
            options: callOptionsFromContext(context))
        .initialize(Empty()));
    var response = await Future.wait(futures);
    deviceConfigurations =
        (response[1] as DeviceConfigurationSelectResponse).result;
    raceFormatTypes = (response[2] as RaceFormatTypeSelectResponse).result;
    trackConfigurationInitialize = response[3];

    return (response[0].entity, response[0].etag);
  }

  @override
  Future<void> save(id) async {
    final proto = TrackCreateUpdate(
      name: formGroup.control('name').value,
      description: StringValue(value: formGroup.control('description').value),
    );

    final trackConfigurationFormArray =
        formGroup.control('trackConfigurations') as FormArray;
    trackConfigurationFormArray.forEachChild((trackConfigurationFormGroup) {
      final trackConfigurationFg = trackConfigurationFormGroup as FormGroup;

      final trackdeviceConfigurationProto = TrackConfigurationReadCreateUpdate(
        id: trackConfigurationFg.control('id').value == null
            ? null
            : StringValue(value: trackConfigurationFg.control('id').value),
        name: StringValue(value: trackConfigurationFg.control('name').value),
        laptimeMinSeconds:
            trackConfigurationFg.control('laptimeMinSeconds').value,
        laptimeMaxSeconds:
            trackConfigurationFg.control('laptimeMaxSeconds').value,
      );

      final deviceConfigurationList =
          trackConfigurationFg.value['deviceConfigurations'] as List;
      for (final deviceConfiguration
          in deviceConfigurationList.where((x) => x['selected'])) {
        trackdeviceConfigurationProto.deviceConfigurationIds
            .add(deviceConfiguration['id']);
      }

      final raceFormatTypeList =
          trackConfigurationFg.value['raceFormatTypes'] as List;
      for (final raceFormatType
          in raceFormatTypeList.where((x) => x['selected'])) {
        trackdeviceConfigurationProto.raceFormatTypeIds
            .add(raceFormatType['id']);
      }

      final trackConfigurationIndicatorsArray = trackConfigurationFg
          .control('trackConfigurationIndicators') as FormArray;
      trackConfigurationIndicatorsArray.forEachChild((formGroup) {
        final fg = formGroup as FormGroup;
        trackdeviceConfigurationProto.trackConfigurationIndicators
            .add(TrackConfigurationIndicatorReadCreateUpdate(
          indicatorId: fg.control('indicatorId').value,
          color: fg.control('color').value,
        ));
      });

      proto.trackConfigurations.add(trackdeviceConfigurationProto);
    });

    if (add) {
      await client().create(proto);
    } else {
      await client()
          .update(TrackUpdateRequest(id: id, entity: proto, etag: etag));
    }
  }

  @override
  Future<void> delete(id) async {
    await client().delete(DeleteRequest(id: id, etag: etag));
  }

  @override
  Future<void> createFormGroup(readProto) async {
    formGroup = FormGroup({
      'name': FormControl<String?>(
          value: readProto.name.hasValue() ? readProto.name.value : null,
          validators: [Validators.required]),
      'description': FormControl<String?>(
          value: readProto.description.hasValue()
              ? readProto.description.value
              : null),
      'trackConfigurations': FormArray([]),
    });

    for (final trackConfigurationProto in readProto.trackConfigurations) {
      trackConfigurationAddFormGroup(trackConfigurationProto, false);
    }
  }

  void trackConfigurationAddFormGroup(
      TrackConfigurationReadCreateUpdate trackConfigurationProto,
      bool markAsDirty) {
    final trackConfigurationArray =
        formGroup.control('trackConfigurations') as FormArray;
    final trackConfigurationFg = FormGroup({
      'id': FormControl<String?>(
          value: trackConfigurationProto.id.hasValue()
              ? trackConfigurationProto.id.value
              : null),
      'name': FormControl<String?>(
          value: trackConfigurationProto.name.hasValue()
              ? trackConfigurationProto.name.value
              : null,
          validators: [Validators.required]),
      'laptimeMinSeconds': FormControl<int>(
          value: trackConfigurationProto.laptimeMinSeconds,
          validators: [Validators.required]),
      'laptimeMaxSeconds': FormControl<int>(
          value: trackConfigurationProto.laptimeMaxSeconds,
          validators: [Validators.required]),
      'deviceConfigurations': FormArray([]),
      'raceFormatTypes': FormArray([]),
      'trackConfigurationIndicators': FormArray([]),
    });
    trackConfigurationArray.add(trackConfigurationFg);

    final deviceConfigurationsArray =
        trackConfigurationFg.control('deviceConfigurations') as FormArray;
    if (deviceConfigurations.isNotEmpty) {
      for (final deviceConfiguration in deviceConfigurations) {
        deviceConfigurationsArray.add(FormGroup({
          'id': FormControl<String>(value: deviceConfiguration.id),
          'name': FormControl<String>(
              value:
                  "${deviceConfiguration.device.name} - ${deviceConfiguration.name}"),
          'selected': FormControl<bool>(
              value: trackConfigurationProto.deviceConfigurationIds
                  .contains(deviceConfiguration.id))
        }));
      }
    }

    final raceFormatTypesArray =
        trackConfigurationFg.control('raceFormatTypes') as FormArray;
    for (final raceFormatType in raceFormatTypes) {
      raceFormatTypesArray.add(FormGroup({
        'id': FormControl<RaceFormatTypeId>(value: raceFormatType.id),
        'name': FormControl<String>(value: raceFormatType.name),
        'selected': FormControl<bool>(
            value: trackConfigurationProto.raceFormatTypeIds
                .contains(raceFormatType.id))
      }));
    }

    final trackConfigurationIndicatorsArray = trackConfigurationFg
        .control('trackConfigurationIndicators') as FormArray;
    for (final trackConfigurationIndicatorProto
        in trackConfigurationProto.trackConfigurationIndicators) {
      trackConfigurationIndicatorsArray.add(FormGroup({
        'indicatorId': FormControl<int>(
            value: trackConfigurationIndicatorProto.indicatorId,
            validators: [Validators.required]),
        'color': FormControl<int>(
            value: trackConfigurationIndicatorProto.color,
            validators: [Validators.required])
      }));
    }

    if (markAsDirty) {
      trackConfigurationFg.markAsDirty();
    }
  }

  void trackConfigurationDelete(FormGroup trackConfigurationFormGroup) {
    final trackConfigurationArray =
        formGroup.control('trackConfigurations') as FormArray;
    trackConfigurationArray.remove(trackConfigurationFormGroup);
    trackConfigurationArray.markAsDirty();
  }

  void trackConfigurationIndicatorAdd(FormArray formArray) {
    final fg = FormGroup({
      'indicatorId': FormControl<int>(validators: [Validators.required]),
      'color': FormControl<int>(validators: [Validators.required])
    });
    formArray.add(fg);
    fg.markAsDirty();
  }

  void trackConfigurationIndicatorDelete(
      FormArray formArray, FormGroup trackConfigurationIndicatorFormGroup) {
    formArray.remove(trackConfigurationIndicatorFormGroup);
    formArray.markAsDirty();
  }
}

class _TenantAdminTrackDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminTrackDetailState>()!;
    final trackConfigurationArray =
        state.formGroup.control('trackConfigurations') as FormArray;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) =>
          DefaultTabController(
        length: 1 + trackConfigurationArray.controls.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(state.header),
            flexibleSpace: const AppProgressIndicator(),
            bottom: TabBar(isScrollable: true, tabs: [
              Tab(text: state.header),
              ...trackConfigurationArray.controls
                  .map((trackConfigurationFormGroup) {
                final fg = trackConfigurationFormGroup as FormGroup;
                final name = fg.control('name').value;
                return Tab(text: name ?? "New track configuration");
              })
            ]),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _TenantAdminTrackDetailBodyMain()),
              ),
              ...trackConfigurationArray.controls.map(
                (trackConfigurationFormGroup) => Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: _TenantAdminTrackConfigurationBody(
                              formGroup:
                                  trackConfigurationFormGroup as FormGroup)),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FilledButton.tonalIcon(
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete track configuration'),
                            onPressed: () => setState(() =>
                                state.trackConfigurationDelete(
                                    trackConfigurationFormGroup))),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: ReactiveFormBottomAppBar(
            widgets: [
              const SizedBox(width: 16),
              FilledButton.tonalIcon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add track configuration'),
                  onPressed: () {
                    state.tabBarAdded = true;
                    // state.trackConfigurationAddFormGroup(state.trackConfigurationInitialize, true);
                    // setState(() {});

                    //DefaultTabController.of(context).animateTo(1);
                    setState(() => state.trackConfigurationAddFormGroup(
                        state.trackConfigurationInitialize, true));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class _TenantAdminTrackDetailBodyMain extends StatelessWidget {
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
            validationMessages: {
              ValidationMessage.required: (error) => 'Please enter a name.'
            },
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

class _TenantAdminTrackConfigurationBody extends StatelessWidget {
  const _TenantAdminTrackConfigurationBody({required this.formGroup});

  final FormGroup formGroup;

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminTrackDetailState>()!;
    return ReactiveForm(
      formGroup: formGroup,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1300),
            child: ReactiveTextField<String?>(
              formControlName: 'name',
              maxLength: 100,
              textCapitalization: TextCapitalization.sentences,
              validationMessages: {
                ValidationMessage.required: (error) => 'Please enter a name.'
              },
              decoration: const InputDecoration(labelText: "Name *"),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: ReactiveTextField<int>(
              formControlName: 'laptimeMinSeconds',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 2,
              decoration: const InputDecoration(
                  counterText: "",
                  labelText: 'Min lap time (s) *',
                  helperMaxLines: 3,
                  helperText:
                      'Laps with lap times less than this value can be used to detect false lap counting'),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: ReactiveTextField<int>(
              formControlName: 'laptimeMaxSeconds',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 3,
              decoration: const InputDecoration(
                  counterText: "",
                  labelText: 'Max lap time (s) *',
                  helperMaxLines: 2,
                  helperText:
                      'The max lap time is used as a time-out when a heat ends and not all cars have crossed the finish line'),
            ),
          ),
          Text('Device configurations',
              style: Theme.of(context).textTheme.bodyLarge),
          if (state.deviceConfigurations.isEmpty)
            const Text('(No device configurations defined)')
          else
            ReactiveFormArray(
                formArrayName: 'deviceConfigurations',
                builder: (context, formArray, child) {
                  final children = <Widget>[];
                  formArray.forEachChild((formGroup) {
                    final fg = formGroup as FormGroup;
                    children.add(
                      ReactiveForm(
                        formGroup: fg,
                        child: ReactiveCheckboxListTile(
                          formControlName: 'selected',
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(fg.control('name').value,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    );
                  });
                  return Column(children: children);
                }),
          Text('Race formats', style: Theme.of(context).textTheme.bodyLarge),
          ReactiveFormArray(
              formArrayName: 'raceFormatTypes',
              builder: (context, formArray, child) {
                final children = <Widget>[];
                formArray.forEachChild((formGroup) {
                  final fg = formGroup as FormGroup;
                  children.add(ReactiveForm(
                      formGroup: fg,
                      child: ReactiveCheckboxListTile(
                          formControlName: 'selected',
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(fg.control('name').value,
                              overflow: TextOverflow.ellipsis))));
                });
                return Column(children: children);
              }),
          _TenantAdminTrackConfigurationIndicator(),
        ],
      ),
    );
  }
}

class _TenantAdminTrackConfigurationIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminTrackDetailState>()!;
    return ReactiveFormArray(
        formArrayName: 'trackConfigurationIndicators',
        builder: (context, formArray, child) {
          final children = <Widget>[];
          children.add(trackConfigurationIndicatorRow(
              indicator: const Text('Indicator#'), color: const Text('Color')));
          formArray.forEachChild((formGroup) {
            final fg = formGroup as FormGroup;
            children.add(
              ReactiveForm(
                key: UniqueKey(),
                formGroup: fg,
                child: trackConfigurationIndicatorRow(
                  indicator: ReactiveTextField<int>(
                      formControlName: 'indicatorId',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 2,
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        counterText: '',
                      ),
                      validationMessages: {
                        ValidationMessage.required: (error) =>
                            'Please enter an indicator#.'
                      }),
                  color: ColorDefinitionField(
                      formGroup: fg, formControlName: 'color', required: true,),
                  delete: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => state.trackConfigurationIndicatorDelete(
                          formArray, fg)),
                ),
              ),
            );
          });
          children.add(const SizedBox(height: 16));
          children.add(IconButton.filledTonal(
            icon: const Icon(Icons.add),
            onPressed: () => state.trackConfigurationIndicatorAdd(formArray),
            tooltip: 'Add a simulated input',
          ));
          return Column(children: children);
        });
  }

  Row trackConfigurationIndicatorRow(
      {required Widget indicator, required Widget color, Widget? delete}) {
    return Row(
      children: [
        SizedBox(width: 100, child: indicator),
        const SizedBox(width: 16),
        SizedBox(width: 300, child: color),
        const SizedBox(width: 16),
        if (delete != null) delete
      ],
    );
  }
}
