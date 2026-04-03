import 'package:protobuf/well_known_types/google/protobuf/duration.pb.dart' as protobuf_duration;

mixin TimerConversion {
  DateTime dateTimeFromProtobufDuration(protobuf_duration.Duration duration) {
    var dt = DateTime.fromMillisecondsSinceEpoch(duration.seconds.toInt() * 1000);
    dt = dt.add(-dt.timeZoneOffset);
    return dt;
  }

  DateTime dateTimeFromDuration(Duration duration) {
    var now = DateTime.now();
    return DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds - now.timeZoneOffset.inMilliseconds, isUtc: true);
  }

  Duration durationFromProtobufDuration(protobuf_duration.Duration? value) {
    if (value == null || !value.hasNanos()) {
      return Duration();
    }
    return Duration(seconds: value.seconds.toInt());
    //        microseconds: (duration.nanos / 1000).round());
    //return Duration(milliseconds: (value.seconds.toInt() * 1000 + value.nanos / 1000000).round());
  }
}
