// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/event.service.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class EventSpeech extends $pb.GeneratedMessage {
  factory EventSpeech({
    $0.BytesValue? speech,
  }) {
    final result = create();
    if (speech != null) result.speech = speech;
    return result;
  }

  EventSpeech._();

  factory EventSpeech.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventSpeech.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventSpeech',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOM<$0.BytesValue>(1, _omitFieldNames ? '' : 'speech',
        subBuilder: $0.BytesValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventSpeech clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventSpeech copyWith(void Function(EventSpeech) updates) =>
      super.copyWith((message) => updates(message as EventSpeech))
          as EventSpeech;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventSpeech create() => EventSpeech._();
  @$core.override
  EventSpeech createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventSpeech getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventSpeech>(create);
  static EventSpeech? _defaultInstance;

  @$pb.TagNumber(1)
  $0.BytesValue get speech => $_getN(0);
  @$pb.TagNumber(1)
  set speech($0.BytesValue value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSpeech() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpeech() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.BytesValue ensureSpeech() => $_ensure(0);
}

class EventUserSpeechSubscribeRequest extends $pb.GeneratedMessage {
  factory EventUserSpeechSubscribeRequest({
    $core.String? eventId,
    $core.String? eventUserId,
    $core.String? locale,
    $core.String? localName,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (eventUserId != null) result.eventUserId = eventUserId;
    if (locale != null) result.locale = locale;
    if (localName != null) result.localName = localName;
    return result;
  }

  EventUserSpeechSubscribeRequest._();

  factory EventUserSpeechSubscribeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventUserSpeechSubscribeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventUserSpeechSubscribeRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..aOS(2, _omitFieldNames ? '' : 'eventUserId')
    ..aOS(3, _omitFieldNames ? '' : 'locale')
    ..aOS(4, _omitFieldNames ? '' : 'localName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventUserSpeechSubscribeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventUserSpeechSubscribeRequest copyWith(
          void Function(EventUserSpeechSubscribeRequest) updates) =>
      super.copyWith(
              (message) => updates(message as EventUserSpeechSubscribeRequest))
          as EventUserSpeechSubscribeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventUserSpeechSubscribeRequest create() =>
      EventUserSpeechSubscribeRequest._();
  @$core.override
  EventUserSpeechSubscribeRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventUserSpeechSubscribeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventUserSpeechSubscribeRequest>(
          create);
  static EventUserSpeechSubscribeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get eventUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set eventUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEventUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEventUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get locale => $_getSZ(2);
  @$pb.TagNumber(3)
  set locale($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLocale() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocale() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get localName => $_getSZ(3);
  @$pb.TagNumber(4)
  set localName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLocalName() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocalName() => $_clearField(4);
}

class EventSpeechSettingsRequest extends $pb.GeneratedMessage {
  factory EventSpeechSettingsRequest({
    $core.String? locale,
  }) {
    final result = create();
    if (locale != null) result.locale = locale;
    return result;
  }

  EventSpeechSettingsRequest._();

  factory EventSpeechSettingsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventSpeechSettingsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventSpeechSettingsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventSpeechSettingsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventSpeechSettingsRequest copyWith(
          void Function(EventSpeechSettingsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as EventSpeechSettingsRequest))
          as EventSpeechSettingsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventSpeechSettingsRequest create() => EventSpeechSettingsRequest._();
  @$core.override
  EventSpeechSettingsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventSpeechSettingsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventSpeechSettingsRequest>(create);
  static EventSpeechSettingsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => $_clearField(1);
}

class EventSpeechSettingsReponse extends $pb.GeneratedMessage {
  factory EventSpeechSettingsReponse({
    $core.Iterable<EventSpeechSettings>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  EventSpeechSettingsReponse._();

  factory EventSpeechSettingsReponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventSpeechSettingsReponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventSpeechSettingsReponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..pPM<EventSpeechSettings>(1, _omitFieldNames ? '' : 'items',
        subBuilder: EventSpeechSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventSpeechSettingsReponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventSpeechSettingsReponse copyWith(
          void Function(EventSpeechSettingsReponse) updates) =>
      super.copyWith(
              (message) => updates(message as EventSpeechSettingsReponse))
          as EventSpeechSettingsReponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventSpeechSettingsReponse create() => EventSpeechSettingsReponse._();
  @$core.override
  EventSpeechSettingsReponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventSpeechSettingsReponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventSpeechSettingsReponse>(create);
  static EventSpeechSettingsReponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<EventSpeechSettings> get items => $_getList(0);
}

class EventSpeechSettings extends $pb.GeneratedMessage {
  factory EventSpeechSettings({
    $core.String? locale,
    $core.String? localeName,
    $core.String? localName,
  }) {
    final result = create();
    if (locale != null) result.locale = locale;
    if (localeName != null) result.localeName = localeName;
    if (localName != null) result.localName = localName;
    return result;
  }

  EventSpeechSettings._();

  factory EventSpeechSettings.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventSpeechSettings.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventSpeechSettings',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..aOS(2, _omitFieldNames ? '' : 'localeName')
    ..aOS(3, _omitFieldNames ? '' : 'localName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventSpeechSettings clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventSpeechSettings copyWith(void Function(EventSpeechSettings) updates) =>
      super.copyWith((message) => updates(message as EventSpeechSettings))
          as EventSpeechSettings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventSpeechSettings create() => EventSpeechSettings._();
  @$core.override
  EventSpeechSettings createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EventSpeechSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventSpeechSettings>(create);
  static EventSpeechSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get localeName => $_getSZ(1);
  @$pb.TagNumber(2)
  set localeName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLocaleName() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocaleName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get localName => $_getSZ(2);
  @$pb.TagNumber(3)
  set localName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLocalName() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocalName() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
