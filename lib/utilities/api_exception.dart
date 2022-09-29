

class ApiException implements Exception{
  late String message;
  ApiException(this.message);
  @override
  String toString() {
    return message;
  }
}