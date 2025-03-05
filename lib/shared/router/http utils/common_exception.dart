class ApiException implements Exception {
  ApiException(this.message, this.statusCode);
  final String message;
  final int statusCode;

  @override
  String toString() {
    return 'CommonException{message: $message, statusCode: $statusCode}';
  }
}
