// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/io/commissioning.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class CommissioningCertificateRequest extends $pb.GeneratedMessage {
  factory CommissioningCertificateRequest({
    $core.String? certificateRequestPem,
    $core.String? name,
  }) {
    final result = create();
    if (certificateRequestPem != null)
      result.certificateRequestPem = certificateRequestPem;
    if (name != null) result.name = name;
    return result;
  }

  CommissioningCertificateRequest._();

  factory CommissioningCertificateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CommissioningCertificateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommissioningCertificateRequest',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.io.commissioning'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'certificateRequestPem')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommissioningCertificateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommissioningCertificateRequest copyWith(
          void Function(CommissioningCertificateRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CommissioningCertificateRequest))
          as CommissioningCertificateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommissioningCertificateRequest create() =>
      CommissioningCertificateRequest._();
  @$core.override
  CommissioningCertificateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CommissioningCertificateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommissioningCertificateRequest>(
          create);
  static CommissioningCertificateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get certificateRequestPem => $_getSZ(0);
  @$pb.TagNumber(1)
  set certificateRequestPem($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCertificateRequestPem() => $_has(0);
  @$pb.TagNumber(1)
  void clearCertificateRequestPem() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
}

class CommissioningCertificateResponse extends $pb.GeneratedMessage {
  factory CommissioningCertificateResponse({
    $core.String? certificatePem,
  }) {
    final result = create();
    if (certificatePem != null) result.certificatePem = certificatePem;
    return result;
  }

  CommissioningCertificateResponse._();

  factory CommissioningCertificateResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CommissioningCertificateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommissioningCertificateResponse',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.io.commissioning'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'certificatePem')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommissioningCertificateResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommissioningCertificateResponse copyWith(
          void Function(CommissioningCertificateResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CommissioningCertificateResponse))
          as CommissioningCertificateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommissioningCertificateResponse create() =>
      CommissioningCertificateResponse._();
  @$core.override
  CommissioningCertificateResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CommissioningCertificateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommissioningCertificateResponse>(
          create);
  static CommissioningCertificateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get certificatePem => $_getSZ(0);
  @$pb.TagNumber(1)
  set certificatePem($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCertificatePem() => $_has(0);
  @$pb.TagNumber(1)
  void clearCertificatePem() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
