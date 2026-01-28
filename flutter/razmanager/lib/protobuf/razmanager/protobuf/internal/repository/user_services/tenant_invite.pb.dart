// This is a generated file - do not edit.
//
// Generated from razmanager/protobuf/internal/repository/user_services/tenant_invite.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class TenantInviteCreate extends $pb.GeneratedMessage {
  factory TenantInviteCreate({
    $core.int? code,
  }) {
    final result = create();
    if (code != null) result.code = code;
    return result;
  }

  TenantInviteCreate._();

  factory TenantInviteCreate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TenantInviteCreate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TenantInviteCreate',
      package: const $pb.PackageName(_omitMessageNames
          ? ''
          : 'razmanager.protobuf.internal.repository.user_services.tenant_invite'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'code')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantInviteCreate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TenantInviteCreate copyWith(void Function(TenantInviteCreate) updates) =>
      super.copyWith((message) => updates(message as TenantInviteCreate))
          as TenantInviteCreate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TenantInviteCreate create() => TenantInviteCreate._();
  @$core.override
  TenantInviteCreate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TenantInviteCreate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TenantInviteCreate>(create);
  static TenantInviteCreate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get code => $_getIZ(0);
  @$pb.TagNumber(1)
  set code($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
