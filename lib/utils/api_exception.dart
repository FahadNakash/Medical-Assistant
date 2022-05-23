

class ApiException implements Exception{
  late String message;
  ApiException(this.message);
  // Map<String,dynamic>? userData;
  @override
  String toString() {
    return message;
  }
}