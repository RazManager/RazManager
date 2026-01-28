import 'package:grpc/grpc.dart' as grpc;

class PermissionDeniedException implements Exception {}

mixin ExceptionMessage {
  String exceptionMessage(Object? exception) {
    if (exception is grpc.GrpcError) {
      switch (exception.code) {
        case 3:
          return exception.message!;
        case 14:
          return "Cannot connect to the RazManager server. ($exception)";

        default:
          return exception.toString();
      }
    } else if (exception is PermissionDeniedException) {
      return ('Invalid username or password.');
    } else {
      return exception.toString();
    }
  }
}
