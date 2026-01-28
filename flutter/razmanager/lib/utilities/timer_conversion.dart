import 'package:protobuf/well_known_types/google/protobuf/duration.pb.dart' as protobuf_duration;

mixin TimerConversion {
  DateTime dateTimeFromProtobufDuration(protobuf_duration.Duration duration) {
    var now = DateTime.now();
    return DateTime.fromMillisecondsSinceEpoch(
        duration.seconds.toInt() * 1000 - now.timeZoneOffset.inMilliseconds,
        isUtc: true);
  }

  DateTime dateTimeFromDuration(Duration duration) {
    var now = DateTime.now();
    return  DateTime.fromMillisecondsSinceEpoch(
        duration.inMilliseconds - now.timeZoneOffset.inMilliseconds ,
        isUtc: true);
  }

  Duration durationFromProtobufDuration(protobuf_duration.Duration duration) {
    return Duration(
        seconds: duration.seconds.toInt());
//        microseconds: (duration.nanos / 1000).round());
  }
}
