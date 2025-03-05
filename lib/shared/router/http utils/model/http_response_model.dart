class ResponseData {
  ResponseData({
    required this.responseCode,
    required this.message, this.success = false,
    this.responseBody,
  });
  final int responseCode;
  final bool success;
  final String message;
  final dynamic responseBody;
}
