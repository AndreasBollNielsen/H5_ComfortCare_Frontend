class APIResponse {
  final Map<String, dynamic> body;
  final int statusCode;
  final String message;
  late String? jwt;

  APIResponse(
      {required this.body,
      required this.statusCode,
      required this.message,
      this.jwt});
}
