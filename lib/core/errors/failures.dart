abstract class Failure {
  final String message;
   Failure(this.message);

  @override
  String toString() {
    return message;
  }
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}