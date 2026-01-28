// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/public/version.v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $1;
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart'
    as $2;

import 'version.v1.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'version.v1.pbenum.dart';

class Version extends $pb.GeneratedMessage {
  factory Version({
    $1.Timestamp? date,
    $core.int? major,
    $core.int? minor,
    $core.int? patch,
    $core.bool? valid,
    $2.StringValue? description,
    $core.Iterable<VersionNote>? notes,
    $core.Iterable<VersionPlatform>? platforms,
  }) {
    final result = create();
    if (date != null) result.date = date;
    if (major != null) result.major = major;
    if (minor != null) result.minor = minor;
    if (patch != null) result.patch = patch;
    if (valid != null) result.valid = valid;
    if (description != null) result.description = description;
    if (notes != null) result.notes.addAll(notes);
    if (platforms != null) result.platforms.addAll(platforms);
    return result;
  }

  Version._();

  factory Version.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Version.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Version',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'date',
        subBuilder: $1.Timestamp.create)
    ..aI(3, _omitFieldNames ? '' : 'major', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'minor', fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'patch', fieldType: $pb.PbFieldType.OU3)
    ..aOB(7, _omitFieldNames ? '' : 'valid')
    ..aOM<$2.StringValue>(8, _omitFieldNames ? '' : 'description',
        subBuilder: $2.StringValue.create)
    ..pPM<VersionNote>(9, _omitFieldNames ? '' : 'notes',
        subBuilder: VersionNote.create)
    ..pPM<VersionPlatform>(10, _omitFieldNames ? '' : 'platforms',
        subBuilder: VersionPlatform.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Version clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Version copyWith(void Function(Version) updates) =>
      super.copyWith((message) => updates(message as Version)) as Version;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Version create() => Version._();
  @$core.override
  Version createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Version getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Version>(create);
  static Version? _defaultInstance;

  @$pb.TagNumber(2)
  $1.Timestamp get date => $_getN(0);
  @$pb.TagNumber(2)
  set date($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(2)
  void clearDate() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureDate() => $_ensure(0);

  @$pb.TagNumber(3)
  $core.int get major => $_getIZ(1);
  @$pb.TagNumber(3)
  set major($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(3)
  $core.bool hasMajor() => $_has(1);
  @$pb.TagNumber(3)
  void clearMajor() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get minor => $_getIZ(2);
  @$pb.TagNumber(4)
  set minor($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(4)
  $core.bool hasMinor() => $_has(2);
  @$pb.TagNumber(4)
  void clearMinor() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get patch => $_getIZ(3);
  @$pb.TagNumber(5)
  set patch($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(5)
  $core.bool hasPatch() => $_has(3);
  @$pb.TagNumber(5)
  void clearPatch() => $_clearField(5);

  @$pb.TagNumber(7)
  $core.bool get valid => $_getBF(4);
  @$pb.TagNumber(7)
  set valid($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(7)
  $core.bool hasValid() => $_has(4);
  @$pb.TagNumber(7)
  void clearValid() => $_clearField(7);

  @$pb.TagNumber(8)
  $2.StringValue get description => $_getN(5);
  @$pb.TagNumber(8)
  set description($2.StringValue value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(8)
  void clearDescription() => $_clearField(8);
  @$pb.TagNumber(8)
  $2.StringValue ensureDescription() => $_ensure(5);

  @$pb.TagNumber(9)
  $pb.PbList<VersionNote> get notes => $_getList(6);

  @$pb.TagNumber(10)
  $pb.PbList<VersionPlatform> get platforms => $_getList(7);
}

class VersionNote extends $pb.GeneratedMessage {
  factory VersionNote({
    $core.String? description,
  }) {
    final result = create();
    if (description != null) result.description = description;
    return result;
  }

  VersionNote._();

  factory VersionNote.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VersionNote.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VersionNote',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionNote clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionNote copyWith(void Function(VersionNote) updates) =>
      super.copyWith((message) => updates(message as VersionNote))
          as VersionNote;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VersionNote create() => VersionNote._();
  @$core.override
  VersionNote createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VersionNote getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VersionNote>(create);
  static VersionNote? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => $_clearField(1);
}

class VersionPlatform extends $pb.GeneratedMessage {
  factory VersionPlatform({
    VersionPlatformId? id,
    $core.String? name,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    return result;
  }

  VersionPlatform._();

  factory VersionPlatform.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VersionPlatform.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VersionPlatform',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aE<VersionPlatformId>(1, _omitFieldNames ? '' : 'id',
        enumValues: VersionPlatformId.values)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionPlatform clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionPlatform copyWith(void Function(VersionPlatform) updates) =>
      super.copyWith((message) => updates(message as VersionPlatform))
          as VersionPlatform;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VersionPlatform create() => VersionPlatform._();
  @$core.override
  VersionPlatform createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VersionPlatform getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VersionPlatform>(create);
  static VersionPlatform? _defaultInstance;

  @$pb.TagNumber(1)
  VersionPlatformId get id => $_getN(0);
  @$pb.TagNumber(1)
  set id(VersionPlatformId value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
}

class VersionAllRequest extends $pb.GeneratedMessage {
  factory VersionAllRequest({
    VersionPlatformId? versionPlatformId,
  }) {
    final result = create();
    if (versionPlatformId != null) result.versionPlatformId = versionPlatformId;
    return result;
  }

  VersionAllRequest._();

  factory VersionAllRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VersionAllRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VersionAllRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aE<VersionPlatformId>(1, _omitFieldNames ? '' : 'versionPlatformId',
        enumValues: VersionPlatformId.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionAllRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionAllRequest copyWith(void Function(VersionAllRequest) updates) =>
      super.copyWith((message) => updates(message as VersionAllRequest))
          as VersionAllRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VersionAllRequest create() => VersionAllRequest._();
  @$core.override
  VersionAllRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VersionAllRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VersionAllRequest>(create);
  static VersionAllRequest? _defaultInstance;

  @$pb.TagNumber(1)
  VersionPlatformId get versionPlatformId => $_getN(0);
  @$pb.TagNumber(1)
  set versionPlatformId(VersionPlatformId value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasVersionPlatformId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersionPlatformId() => $_clearField(1);
}

class VersionAllResponse extends $pb.GeneratedMessage {
  factory VersionAllResponse({
    $core.Iterable<Version>? result,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    return result$;
  }

  VersionAllResponse._();

  factory VersionAllResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VersionAllResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VersionAllResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..pPM<Version>(1, _omitFieldNames ? '' : 'result',
        subBuilder: Version.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionAllResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionAllResponse copyWith(void Function(VersionAllResponse) updates) =>
      super.copyWith((message) => updates(message as VersionAllResponse))
          as VersionAllResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VersionAllResponse create() => VersionAllResponse._();
  @$core.override
  VersionAllResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VersionAllResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VersionAllResponse>(create);
  static VersionAllResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Version> get result => $_getList(0);
}

class VersionNewerRequest extends $pb.GeneratedMessage {
  factory VersionNewerRequest({
    VersionPlatformId? versionPlatformId,
    $core.int? currentVersionMajor,
    $core.int? currentVersionMinor,
    $core.int? currentVersionPatch,
    $core.int? confirmedVersionMajor,
    $core.int? confirmedVersionMinor,
    $core.int? confirmedVersionPatch,
  }) {
    final result = create();
    if (versionPlatformId != null) result.versionPlatformId = versionPlatformId;
    if (currentVersionMajor != null)
      result.currentVersionMajor = currentVersionMajor;
    if (currentVersionMinor != null)
      result.currentVersionMinor = currentVersionMinor;
    if (currentVersionPatch != null)
      result.currentVersionPatch = currentVersionPatch;
    if (confirmedVersionMajor != null)
      result.confirmedVersionMajor = confirmedVersionMajor;
    if (confirmedVersionMinor != null)
      result.confirmedVersionMinor = confirmedVersionMinor;
    if (confirmedVersionPatch != null)
      result.confirmedVersionPatch = confirmedVersionPatch;
    return result;
  }

  VersionNewerRequest._();

  factory VersionNewerRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VersionNewerRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VersionNewerRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..aE<VersionPlatformId>(1, _omitFieldNames ? '' : 'versionPlatformId',
        enumValues: VersionPlatformId.values)
    ..aI(2, _omitFieldNames ? '' : 'currentVersionMajor',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'currentVersionMinor',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'currentVersionPatch',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'confirmedVersionMajor',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'confirmedVersionMinor',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(7, _omitFieldNames ? '' : 'confirmedVersionPatch',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionNewerRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionNewerRequest copyWith(void Function(VersionNewerRequest) updates) =>
      super.copyWith((message) => updates(message as VersionNewerRequest))
          as VersionNewerRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VersionNewerRequest create() => VersionNewerRequest._();
  @$core.override
  VersionNewerRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VersionNewerRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VersionNewerRequest>(create);
  static VersionNewerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  VersionPlatformId get versionPlatformId => $_getN(0);
  @$pb.TagNumber(1)
  set versionPlatformId(VersionPlatformId value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasVersionPlatformId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersionPlatformId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get currentVersionMajor => $_getIZ(1);
  @$pb.TagNumber(2)
  set currentVersionMajor($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrentVersionMajor() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentVersionMajor() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get currentVersionMinor => $_getIZ(2);
  @$pb.TagNumber(3)
  set currentVersionMinor($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentVersionMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentVersionMinor() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get currentVersionPatch => $_getIZ(3);
  @$pb.TagNumber(4)
  set currentVersionPatch($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrentVersionPatch() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentVersionPatch() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get confirmedVersionMajor => $_getIZ(4);
  @$pb.TagNumber(5)
  set confirmedVersionMajor($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasConfirmedVersionMajor() => $_has(4);
  @$pb.TagNumber(5)
  void clearConfirmedVersionMajor() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get confirmedVersionMinor => $_getIZ(5);
  @$pb.TagNumber(6)
  set confirmedVersionMinor($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasConfirmedVersionMinor() => $_has(5);
  @$pb.TagNumber(6)
  void clearConfirmedVersionMinor() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get confirmedVersionPatch => $_getIZ(6);
  @$pb.TagNumber(7)
  set confirmedVersionPatch($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasConfirmedVersionPatch() => $_has(6);
  @$pb.TagNumber(7)
  void clearConfirmedVersionPatch() => $_clearField(7);
}

class VersionNewerResponse extends $pb.GeneratedMessage {
  factory VersionNewerResponse({
    $core.Iterable<Version>? result,
    $core.bool? currentVersionValid,
  }) {
    final result$ = create();
    if (result != null) result$.result.addAll(result);
    if (currentVersionValid != null)
      result$.currentVersionValid = currentVersionValid;
    return result$;
  }

  VersionNewerResponse._();

  factory VersionNewerResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VersionNewerResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VersionNewerResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'razmanager.protobuf.public.v1'),
      createEmptyInstance: create)
    ..pPM<Version>(1, _omitFieldNames ? '' : 'result',
        subBuilder: Version.create)
    ..aOB(2, _omitFieldNames ? '' : 'currentVersionValid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionNewerResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VersionNewerResponse copyWith(void Function(VersionNewerResponse) updates) =>
      super.copyWith((message) => updates(message as VersionNewerResponse))
          as VersionNewerResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VersionNewerResponse create() => VersionNewerResponse._();
  @$core.override
  VersionNewerResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VersionNewerResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VersionNewerResponse>(create);
  static VersionNewerResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Version> get result => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get currentVersionValid => $_getBF(1);
  @$pb.TagNumber(2)
  set currentVersionValid($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrentVersionValid() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentVersionValid() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
