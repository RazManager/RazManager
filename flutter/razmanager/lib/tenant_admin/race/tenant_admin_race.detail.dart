import 'dart:async';

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';
import 'package:protobuf/well_known_types/google/protobuf/duration.pb.dart';

import '../../app_model.dart';
import '../../app_progress_indicator.dart';
import '../../protobuf/razmanager/protobuf/public/heat.v1.pb.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/car.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/car_tag.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/event.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/heat_car_type.pbenum.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/race.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/race_format_type.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/track_configuration.pbgrpc.dart';
import '../../utilities/color_definitions.dart';
import '../../utilities/crud_master_detail_base.dart';
import '../../utilities/exception_message.dart';

class TenantAdminRaceDetail extends CrudMasterDetailBase {
  const TenantAdminRaceDetail({super.key, required super.id, required super.oldEtag, required super.refreshItems});

  @override
  State createState() => _TenantAdminRaceState();
}

class _TenantAdminRaceState extends CrudMasterDetailStateBase<RaceRead> {
  _TenantAdminRaceState() : super(header: 'Race', child: _TenantAdminRaceDetailBody());

  late Iterable<EventSelect> events;
  late Iterable<TrackConfigurationSelect> trackConfigurations;
  late Iterable<CarTagSelect> carTags;
  Set<String> carTagFilters = {};
  late Iterable<CarSelect> cars;

  RaceServiceClient client() {
    return RaceServiceClient(clientChannel!, options: callOptionsFromContext(context));
  }

  @override
  Future<RaceRead> initialize() async {
    final futures = <Future>[];
    futures.add(client().initialize(Empty()));
    futures.add(EventServiceClient(clientChannel!, options: callOptionsFromContext(context)).select(Empty()));
    futures.add(TrackConfigurationServiceClient(clientChannel!, options: callOptionsFromContext(context)).select(Empty()));
    futures.add(CarTagServiceClient(clientChannel!, options: callOptionsFromContext(context)).select(Empty()));
    futures.add(CarServiceClient(clientChannel!, options: callOptionsFromContext(context)).select(Empty()));
    var response = await Future.wait(futures);
    events = (response[1] as EventSelectResponse).result;
    trackConfigurations = (response[2] as TrackConfigurationSelectResponse).result;
    carTags = (response[3] as CarTagSelectResponse).result;
    cars = (response[4] as CarSelectResponse).result;

    return (response[0] as RaceRead);
  }

  @override
  Future read(id) async {
    final futures = <Future>[];
    futures.add(client().read(IdRequest(id: id)));
    futures.add(CarTagServiceClient(clientChannel!, options: callOptionsFromContext(context)).select(Empty()));
    futures.add(CarServiceClient(clientChannel!, options: callOptionsFromContext(context)).select(Empty()));
    var response = await Future.wait(futures);
    carTags = (response[1] as CarTagSelectResponse).result;
    cars = (response[2] as CarSelectResponse).result;

    return (response[0].entity, response[0].etag);
  }

  EventSelect? event() {
    if (add) {
      return events.where((x) => x.id == formGroup.control('eventId').value).singleOrNull;
    } else {
      return readProto.event;
    }
  }

  TrackConfigurationSelect? trackConfiguration() {
    if (add) {
      return trackConfigurations.where((x) => x.id == formGroup.control('trackConfigurationId').value).singleOrNull;
    } else {
      return readProto.trackConfiguration;
    }
  }

  bool? indicatorEventUserCombined() {
    final trackConfigurationSelect = trackConfiguration();
    final raceFormatTypeId = formGroup.control('raceFormatTypeId').value;
    final raceFormatTypeSelect = trackConfigurationSelect?.trackConfigurationRaceFormats.where((x) => x.id == raceFormatTypeId).singleOrNull;

    if (raceFormatTypeSelect == null) {
      return null;
    } else {
      return raceFormatTypeSelect.indicatorEventUserCombined;
    }
  }

  @override
  Future<void> save(id) {
    List<RaceEventUserReadCreateUpdate> raceEventUsers = [];
    final raceEventUsersList = formGroup.value['raceEventUsers'] as List;
    for (final raceEventUser in raceEventUsersList.where((x) => x['selected'])) {
      final proto = RaceEventUserReadCreateUpdate(eventUserId: raceEventUser['id']);
      if (raceEventUser['carId'] != null) {
        proto.carId = StringValue(value: raceEventUser['carId']);
      }
      raceEventUsers.add(proto);
    }

    List<RaceIndicatorReadCreateUpdate> raceIndicators = [];
    final raceIndicatorsList = formGroup.value['raceIndicators'] as List;
    for (final raceIndicator in raceIndicatorsList.where((x) => x['selected'])) {
      final proto = RaceIndicatorReadCreateUpdate(indicatorId: raceIndicator['indicatorId']);
      if (raceIndicator['carId'] != null) {
        proto.carId = StringValue(value: raceIndicator['carId']);
      }
      raceIndicators.add(proto);
    }

    List<RaceIndicatorEventUserReadCreateUpdate> raceIndicatorEventUsers = [];
    final raceIndicatorEventUsersList = formGroup.value['raceIndicatorEventUsers'] as List;
    for (final raceIndicatorEventUser in raceIndicatorEventUsersList.where((x) => x['selected'])) {
      final proto = RaceIndicatorEventUserReadCreateUpdate(
        indicatorId: raceIndicatorEventUser['indicatorId'],
        eventUserId: raceIndicatorEventUser['eventUserId'],
      );

      final carClassColor = raceIndicatorEventUser['carClassColor'] as ColorDefinition?;
      if (carClassColor != null) {
        proto.carClassColor = UInt32Value(value: carClassColor.color.value);
      }

      if (raceIndicatorEventUser['carId'] != null) {
        proto.carId = StringValue(value: raceIndicatorEventUser['carId']);
      }
      raceIndicatorEventUsers.add(proto);
    }

    final raceUpdateProto = RaceUpdate(
      name: StringValue(value: formGroup.control('name').value),
      practiceSession: formGroup.control('practiceSession').value,
      qualifyingSession: formGroup.control('qualifyingSession').value,
      raceSession: formGroup.control('raceSession').value,
      raceFormatTypeId: formGroup.control('raceFormatTypeId').value,
      raceHeatEndTypeId: formGroup.control('raceHeatEndTypeId').value,
      raceHeatEndLapLaps: formGroup.control('raceHeatEndTypeId').value == HeatEndTypeId.HEAT_END_TYPE_ID_LAP
          ? UInt32Value(value: formGroup.control('raceHeatEndLapLaps').value)
          : null,
      raceHeatEndDurationDuration: formGroup.control('raceHeatEndTypeId').value == HeatEndTypeId.HEAT_END_TYPE_ID_DURATION
          ? Duration(
              seconds: $fixnum.Int64(formGroup.control('raceHeatDurarationHours').value * 3600 + formGroup.control('raceHeatDurarationMinutes').value * 60),
            )
          : null,
      heatCarTypeId: formGroup.control('heatCarTypeId').value,
      carTagIds: carTagFilters,
      raceEventUsers: raceEventUsers,
      raceIndicators: raceIndicators,
      raceIndicatorEventUsers: raceIndicatorEventUsers,
      energySimulation: formGroup.control('energySimulation').value,
    );

    if (add) {
      final proto = RaceCreate(
        eventId: formGroup.control('eventId').value,
        trackConfigurationId: formGroup.control('trackConfigurationId').value,
        name: raceUpdateProto.name,
        practiceSession: raceUpdateProto.practiceSession,
        qualifyingSession: raceUpdateProto.qualifyingSession,
        raceSession: raceUpdateProto.raceSession,
        raceFormatTypeId: raceUpdateProto.raceFormatTypeId,
        raceHeatEndTypeId: raceUpdateProto.raceHeatEndTypeId,
        raceHeatEndLapLaps: raceUpdateProto.raceHeatEndLapLaps,
        raceHeatEndDurationDuration: raceUpdateProto.raceHeatEndDurationDuration,
        heatCarTypeId: raceUpdateProto.heatCarTypeId,
        carTagIds: raceUpdateProto.carTagIds,
        raceEventUsers: raceUpdateProto.raceEventUsers,
        raceIndicators: raceUpdateProto.raceIndicators,
        raceIndicatorEventUsers: raceUpdateProto.raceIndicatorEventUsers,
        energySimulation: raceUpdateProto.energySimulation,
      );
      return client().create(proto);
    } else {
      return client().update(RaceUpdateRequest(id: id, entity: raceUpdateProto, etag: etag));
    }
  }

  @override
  Future<void> delete(id) {
    return client().delete(DeleteRequest(id: id, etag: etag));
  }

  @override
  Future<void> createFormGroup(readProto) async {
    formGroup = FormGroup({
      'eventId': FormControl<String?>(value: readProto.eventId.hasValue() ? readProto.eventId.value : null, validators: [Validators.required]),
      'trackConfigurationId': FormControl<String?>(
        value: readProto.trackConfigurationId.hasValue() ? readProto.trackConfigurationId.value : null,
        validators: [Validators.required],
      ),
      'name': FormControl<String?>(value: readProto.name.hasValue() ? readProto.name.value : null),
      'practiceSession': FormControl<bool>(value: readProto.practiceSession, validators: [Validators.required]),
      'qualifyingSession': FormControl<bool>(value: readProto.qualifyingSession, validators: [Validators.required]),
      'raceSession': FormControl<bool>(value: readProto.raceSession, validators: [Validators.required]),
      'raceFormatTypeId': FormControl<RaceFormatTypeId>(value: readProto.raceFormatTypeId, validators: [Validators.required]),
      'raceHeatEndTypeId': FormControl<HeatEndTypeId>(value: readProto.raceHeatEndTypeId, validators: [Validators.required]),
      'raceHeatEndLapLaps': FormControl<int>(
        value: readProto.raceHeatEndLapLaps.hasValue() ? readProto.raceHeatEndLapLaps.value : null,
        validators: [Validators.min(1), Validators.max(1000), Validators.required],
      ),
      'raceHeatDurarationHours': FormControl<int>(
        value: readProto.raceHeatEndDurationDuration.hasSeconds() ? (readProto.raceHeatEndDurationDuration.seconds.toInt() / 3600).floor() : null,
        validators: [Validators.max(24)],
      ),
      'raceHeatDurarationMinutes': FormControl<int>(
        value: readProto.raceHeatEndDurationDuration.hasSeconds() ? (readProto.raceHeatEndDurationDuration.seconds.toInt() % 3600) ~/ 60 : null,
        validators: [Validators.max(59), Validators.required],
      ),
      'heatCarTypeId': FormControl<HeatCarTypeId>(value: readProto.heatCarTypeId, validators: [Validators.required]),
      'raceEventUsers': FormArray([]),
      'raceIndicators': FormArray([]),
      'raceIndicatorEventUsers': FormArray([]),
      'energySimulation': FormControl<bool>(value: readProto.energySimulation, validators: [Validators.required]),
    });

    carTagFilters = readProto.carTagIds.toSet();

    final eventSelect = event();
    if (eventSelect != null) {
      final raceEventUsersArray = formGroup.control('raceEventUsers') as FormArray;
      for (final eventUser in eventSelect.eventUsers) {
        final raceEventUser = readProto.raceEventUsers.where((x) => x.eventUserId == eventUser.id).singleOrNull;
        raceEventUsersArray.add(
          FormGroup({
            'id': FormControl<String>(value: eventUser.id),
            'name': FormControl<String>(value: eventUser.name),
            'shortName': FormControl<String?>(value: eventUser.shortName.hasValue() ? eventUser.shortName.value : null),
            'image': FormControl<List<int>?>(value: eventUser.image.hasValue() ? eventUser.image.value : null),
            'carId': FormControl<String?>(value: raceEventUser != null && raceEventUser.carId.hasValue() ? raceEventUser.carId.value : null),
            'selected': FormControl<bool>(value: readProto.raceEventUsers.any((x) => x.eventUserId == eventUser.id)),
          }),
        );
      }
    }

    final trackConfigurationSelect = trackConfiguration();
    if (trackConfigurationSelect != null) {
      final raceIndicatorsArray = formGroup.control('raceIndicators') as FormArray;
      final raceIndicatorEventUsersArray = formGroup.control('raceIndicatorEventUsers') as FormArray;
      for (final trackConfigurationIndicator in trackConfigurationSelect.trackConfigurationIndicators) {
        final raceIndicator = readProto.raceIndicators.where((x) => x.indicatorId == trackConfigurationIndicator.indicatorId).singleOrNull;
        raceIndicatorsArray.add(
          FormGroup({
            'indicatorId': FormControl<int>(value: trackConfigurationIndicator.indicatorId),
            'color': FormControl<int?>(value: trackConfigurationIndicator.color.hasValue() ? trackConfigurationIndicator.color.value : null),
            'carId': FormControl<String?>(value: raceIndicator != null && raceIndicator.carId.hasValue() ? raceIndicator.carId.value : null),
            'selected': FormControl<bool>(value: readProto.raceIndicators.any((x) => x.indicatorId == trackConfigurationIndicator.indicatorId)),
          }),
        );
        final raceIndicatorEventUser = readProto.raceIndicatorEventUsers.where((x) => x.indicatorId == trackConfigurationIndicator.indicatorId).singleOrNull;
        raceIndicatorEventUsersArray.add(
          FormGroup({
            'indicatorId': FormControl<int>(value: trackConfigurationIndicator.indicatorId),
            'color': FormControl<int?>(value: trackConfigurationIndicator.color.hasValue() ? trackConfigurationIndicator.color.value : null),
            'eventUserId': FormControl<String?>(value: raceIndicatorEventUser?.eventUserId),
            'carClassColor': FormControl<ColorDefinition?>(
              value: raceIndicatorEventUser != null && raceIndicatorEventUser.carClassColor.hasValue()
                  ? ColorDefinition.fromColor(raceIndicatorEventUser.carClassColor.value)
                  : null,
            ),
            'carId': FormControl<String?>(
              value: raceIndicatorEventUser != null && raceIndicatorEventUser.carId.hasValue() ? raceIndicatorEventUser.carId.value : null,
            ),
            'selected': FormControl<bool>(value: raceIndicatorEventUser != null),
          }),
        );
      }
    }
  }
}

class _TenantAdminRaceDetailBody extends StatelessWidget with ExceptionMessage {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminRaceState>()!;

    return Scaffold(
      appBar: AppBar(title: Text(state.header), flexibleSpace: const AppProgressIndicator()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.add)
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1300),
                  child: ReactiveDropdownField<String?>(
                    formControlName: 'eventId',
                    validationMessages: {ValidationMessage.required: (error) => 'Please select an event.'},
                    decoration: const InputDecoration(labelText: 'Event *'),
                    items: state.events.map((x) => DropdownMenuItem(value: x.id, child: Text(x.name))).toList(),
                  ),
                )
              else
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: state.readProto.event.name),
                  decoration: const InputDecoration(labelText: 'Event', border: InputBorder.none),
                ),
              if (state.add)
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1300),
                  child: ReactiveDropdownField<String?>(
                    formControlName: 'trackConfigurationId',
                    validationMessages: {ValidationMessage.required: (error) => 'Please select a track configuration.'},
                    decoration: const InputDecoration(labelText: 'Track configuration *'),
                    items: state.trackConfigurations.map((x) => DropdownMenuItem(value: x.id, child: Text("${x.track.name} - ${x.name}"))).toList(),
                  ),
                )
              else
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: "${state.readProto.trackConfiguration.track.name} - ${state.readProto.trackConfiguration.name}"),
                  decoration: const InputDecoration(labelText: 'Track configuration', border: InputBorder.none),
                ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1300),
                child: ReactiveTextField<String?>(
                  formControlName: 'name',
                  maxLength: 100,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
              ),
              ReactiveCheckboxListTile(
                formControlName: 'practiceSession',
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Practice session'),
              ),
              ReactiveCheckboxListTile(
                formControlName: 'qualifyingSession',
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Qualifying session'),
              ),
              ReactiveCheckboxListTile(formControlName: 'raceSession', controlAffinity: ListTileControlAffinity.leading, title: const Text('Race session')),
              const SizedBox(height: 16),
              Text('Race format *', style: Theme.of(context).textTheme.bodyLarge),
              if (state.trackConfiguration() == null)
                const Text('(No track configuration selected)')
              else
                ...state.trackConfiguration()!.trackConfigurationRaceFormats.map(
                  (x) => ReactiveRadioListTile<RaceFormatTypeId>(formControlName: "raceFormatTypeId", value: x.id, title: Text(x.name)),
                ),
              const SizedBox(height: 16),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  switch (state.formGroup.control('raceHeatEndTypeId').value) {
                    case HeatEndTypeId.HEAT_END_TYPE_ID_UNDEFINED:
                      state.formGroup.control('raceHeatEndLapLaps').markAsDisabled();
                      state.formGroup.control('raceHeatDurarationHours').markAsDisabled();
                      state.formGroup.control('raceHeatDurarationMinutes').markAsDisabled();
                      break;

                    case HeatEndTypeId.HEAT_END_TYPE_ID_LAP:
                      state.formGroup.control('raceHeatEndLapLaps').markAsEnabled();
                      state.formGroup.control('raceHeatDurarationHours').markAsDisabled();
                      state.formGroup.control('raceHeatDurarationMinutes').markAsDisabled();
                      break;

                    case HeatEndTypeId.HEAT_END_TYPE_ID_DURATION:
                      state.formGroup.control('raceHeatEndLapLaps').markAsDisabled();
                      state.formGroup.control('raceHeatDurarationHours').markAsEnabled();
                      state.formGroup.control('raceHeatDurarationMinutes').markAsEnabled();
                      break;

                    case HeatEndTypeId.HEAT_END_TYPE_ID_MANUAL:
                      state.formGroup.control('raceHeatEndLapLaps').markAsDisabled();
                      state.formGroup.control('raceHeatDurarationHours').markAsDisabled();
                      state.formGroup.control('raceHeatDurarationMinutes').markAsDisabled();
                      break;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Heat ending *', style: Theme.of(context).textTheme.bodyLarge),
                      Row(
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: ReactiveRadioListTile<HeatEndTypeId>(
                              formControlName: "raceHeatEndTypeId",
                              value: HeatEndTypeId.HEAT_END_TYPE_ID_LAP,
                              title: const Text('Number of laps'),
                              onChanged: (control) => setState(() {}),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: ReactiveTextField<int>(
                              formControlName: 'raceHeatEndLapLaps',
                              validationMessages: {
                                ValidationMessage.min: (error) => 'Number of laps must be between 1 and 1000.',
                                ValidationMessage.max: (error) => 'Number of laps must be between 1 and 1000.',
                                ValidationMessage.required: (error) => 'Please enter number of laps.',
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              maxLength: 4,
                              decoration: const InputDecoration(counterText: "", labelText: 'Laps'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: ReactiveRadioListTile<HeatEndTypeId>(
                              formControlName: "raceHeatEndTypeId",
                              value: HeatEndTypeId.HEAT_END_TYPE_ID_DURATION,
                              title: const Text('Elapsed time'),
                              onChanged: (control) => setState(() {}),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: ReactiveTextField<int>(
                              formControlName: 'raceHeatDurarationHours',
                              validationMessages: {ValidationMessage.max: (error) => 'Hours must be between 0 and 24.'},
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              maxLength: 4,
                              decoration: const InputDecoration(counterText: "", labelText: 'Hours'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: ReactiveTextField<int>(
                              formControlName: 'raceHeatDurarationMinutes',
                              validationMessages: {ValidationMessage.max: (error) => 'Minutes must be between 0 and 59.'},
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              maxLength: 4,
                              decoration: const InputDecoration(counterText: "", labelText: 'Minutes'),
                            ),
                          ),
                        ],
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: ReactiveRadioListTile<HeatEndTypeId>(
                          formControlName: "raceHeatEndTypeId",
                          value: HeatEndTypeId.HEAT_END_TYPE_ID_MANUAL,
                          title: const Text('Manually ended by race control'),
                          onChanged: (control) => setState(() {}),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lanes/controllers and drivers *', style: Theme.of(context).textTheme.bodyLarge),
                      ReactiveRadioListTile<HeatCarTypeId>(
                        formControlName: "heatCarTypeId",
                        value: HeatCarTypeId.HEAT_CAR_TYPE_ID_NONE,
                        title: const Text('Do not use car images'),
                        onChanged: (control) => setState(() {}),
                      ),
                      ReactiveRadioListTile<HeatCarTypeId>(
                        formControlName: "heatCarTypeId",
                        value: HeatCarTypeId.HEAT_CAR_TYPE_ID_DRIVER,
                        title: const Text('Use the same car for the same driver'),
                        onChanged: (control) => setState(() {}),
                      ),
                      ReactiveRadioListTile<HeatCarTypeId>(
                        formControlName: "heatCarTypeId",
                        value: HeatCarTypeId.HEAT_CAR_TYPE_ID_INDICATOR,
                        title: const Text('Use the same car for the same lane#/controller#'),
                        onChanged: (control) => setState(() {}),
                      ),
                      if (state.carTags.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text('Car tags', style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: state.carTags
                              .map(
                                (x) => InputChip(
                                  label: Text(x.name),
                                  selected: state.carTagFilters.contains(x.id),
                                  onSelected: (value) {
                                    setState(() {
                                      if (value) {
                                        state.carTagFilters.add(x.id);
                                      } else {
                                        state.carTagFilters.remove(x.id);
                                      }
                                      state.formGroup.markAsDirty();
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],
                      const SizedBox(height: 16),
                      if (state.indicatorEventUserCombined() == false) ...[
                        ReactiveFormArray(
                          formArrayName: 'raceEventUsers',
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
                                    title: Row(
                                      children: [
                                        if (fg.control('image').value != null)
                                          CircleAvatar(foregroundImage: MemoryImage(Uint8List.fromList(fg.control('image').value)))
                                        else
                                          const Icon(Icons.person, size: 40),
                                        const SizedBox(width: 8),
                                        Text(fg.control('name').value),
                                        if (state.formGroup.control('heatCarTypeId').value == HeatCarTypeId.HEAT_CAR_TYPE_ID_DRIVER) ...[
                                          const SizedBox(width: 16),
                                          carIdReactiveDropdownField(state, setState, fg),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                            return Column(children: children);
                          },
                        ),
                        const SizedBox(height: 16),
                        ReactiveFormArray(
                          formArrayName: 'raceIndicators',
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
                                    title: Row(
                                      children: [
                                        Text(fg.control('indicatorId').value.toString()),
                                        if (fg.control('color').value != null) ...[
                                          const SizedBox(width: 8),
                                          CircleAvatar(backgroundColor: Color(fg.control('color').value)),
                                        ],
                                        if (state.formGroup.control('heatCarTypeId').value == HeatCarTypeId.HEAT_CAR_TYPE_ID_INDICATOR) ...[
                                          const SizedBox(width: 16),
                                          carIdReactiveDropdownField(state, setState, fg),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                            return Column(children: children);
                          },
                        ),
                      ],
                      if (state.indicatorEventUserCombined() == true)
                        ReactiveFormArray(
                          formArrayName: 'raceIndicatorEventUsers',
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
                                    title: Row(
                                      children: [
                                        Text(fg.control('indicatorId').value.toString()),
                                        if (fg.control('color').value != null) CircleAvatar(backgroundColor: Color(fg.control('color').value)),
                                        const SizedBox(width: 16),
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(maxWidth: 500),
                                          child: ReactiveDropdownField<String?>(
                                            formControlName: 'eventUserId',
                                            validationMessages: {ValidationMessage.required: (error) => 'Please select a driver.'},
                                            decoration: const InputDecoration(labelText: 'Driver *'),
                                            items: state.event()!.eventUsers.map((x) => DropdownMenuItem(value: x.id, child: Text(x.name))).toList(),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(maxWidth: 500),
                                          child: ReactiveDropdownField<ColorDefinition?>(
                                            formControlName: 'carClassColor',
                                            validationMessages: {ValidationMessage.required: (error) => 'Please select a driver.'},
                                            decoration: const InputDecoration(labelText: 'Car class color'),
                                            items: [
                                              DropdownMenuItem(value: null, child: const Text('')),
                                              ...ColorDefinitions.accents.map((x) => DropdownMenuItem(value: x, child: Text(x.name))),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        carIdReactiveDropdownField(state, setState, fg),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                            return Column(children: children);
                          },
                        ),
                    ],
                  );
                },
              ),
              ReactiveCheckboxListTile(
                formControlName: 'energySimulation',
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Energy simulation'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ReactiveFormBottomAppBar(widgets: extraBottomNavigationBarWidgets(context)),
    );
  }

  Iterable<Widget> extraBottomNavigationBarWidgets(BuildContext context) {
    final state = context.findAncestorStateOfType<_TenantAdminRaceState>()!;
    return [
      if (!state.add) ...[
        const SizedBox(width: 16),
        ReactiveFormConsumer(
          builder: (context, form, _) => FilledButton.tonalIcon(
            icon: const Icon(Icons.copy),
            label: const Text('Copy'),
            onPressed: form.dirty
                ? null
                : () async {
                    final model = context.read<AppModel>();
                    model.setBusy(value: true, notify: true);
                    state.clientChannel = state.createClientChannel();
                    try {
                      await state.client().copy(IdRequest(id: state.widget.id));
                      if (state.widget.refreshItems != null) {
                        await state.widget.refreshItems!();
                      }
                      state.onSaved();
                      if (!context.mounted) {
                        return;
                      }
                      if (state.shouldPop) {
                        context.pop();
                      }
                    } on Exception catch (exception) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(exceptionMessage(exception)),
                          //duration: Duration(seconds: 10)
                        ),
                      );
                    } finally {
                      if (state.clientChannel != null) {
                        await state.clientChannel!.shutdown();
                      }
                      model.setBusy(value: false, notify: true);
                    }
                  },
          ),
        ),
      ],
    ];
  }

  Widget carIdReactiveDropdownField(_TenantAdminRaceState state, StateSetter setState, FormGroup fg) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: ReactiveDropdownField<String?>(
        formControlName: 'carId',
        decoration: InputDecoration(
          labelText: 'Car',
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                fg.control("carId").value = null;
                fg.control("carId").markAsDirty();
              });
            },
          ),
        ),
        items: state.cars
            .where((x) => state.carTagFilters.isEmpty || state.carTagFilters.intersection(x.carTagIds.toSet()).isNotEmpty || x.id == fg.control("carId").value)
            .map(
              (x) => DropdownMenuItem(
                value: x.id,
                child: Row(
                  children: [
                    if (x.hasImage() && x.image.value.isNotEmpty) CircleAvatar(foregroundImage: MemoryImage(Uint8List.fromList(x.image.value))),
                    Text(x.name),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
