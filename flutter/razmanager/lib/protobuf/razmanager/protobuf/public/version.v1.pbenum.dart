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

class VersionPlatformId extends $pb.ProtobufEnum {
  static const VersionPlatformId VERSION_PLATFORM_ID_SERVER =
      VersionPlatformId._(
          0, _omitEnumNames ? '' : 'VERSION_PLATFORM_ID_SERVER');
  static const VersionPlatformId VERSION_PLATFORM_ID_WINDOWS =
      VersionPlatformId._(
          1, _omitEnumNames ? '' : 'VERSION_PLATFORM_ID_WINDOWS');
  static const VersionPlatformId VERSION_PLATFORM_ID_LINUX =
      VersionPlatformId._(2, _omitEnumNames ? '' : 'VERSION_PLATFORM_ID_LINUX');
  static const VersionPlatformId VERSION_PLATFORM_ID_MACOS =
      VersionPlatformId._(3, _omitEnumNames ? '' : 'VERSION_PLATFORM_ID_MACOS');
  static const VersionPlatformId VERSION_PLATFORM_ID_IOS =
      VersionPlatformId._(4, _omitEnumNames ? '' : 'VERSION_PLATFORM_ID_IOS');
  static const VersionPlatformId VERSION_PLATFORM_ID_ANDROID =
      VersionPlatformId._(
          5, _omitEnumNames ? '' : 'VERSION_PLATFORM_ID_ANDROID');

  static const $core.List<VersionPlatformId> values = <VersionPlatformId>[
    VERSION_PLATFORM_ID_SERVER,
    VERSION_PLATFORM_ID_WINDOWS,
    VERSION_PLATFORM_ID_LINUX,
    VERSION_PLATFORM_ID_MACOS,
    VERSION_PLATFORM_ID_IOS,
    VERSION_PLATFORM_ID_ANDROID,
  ];

  static final $core.List<VersionPlatformId?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static VersionPlatformId? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const VersionPlatformId._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
