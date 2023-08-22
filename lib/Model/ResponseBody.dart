class APIResponse {
  final Map<String, dynamic> body;
  final int statusCode;
  final String message;

  APIResponse(
      {required this.body, required this.statusCode, required this.message});

  // void SetMessage() {
  //   switch (StatusCode) {
  //     case '200':
  //       print('status: 200 OK');
  //       Message = '200';
  //       break;
  //     case '400':
  //       print('bad request: 400');
  //       Message = '400';
  //       break;
  //     case '401':
  //       print('unauthorized: 401');
  //       Message = '401';
  //       break;
  //     case '404':
  //       print('not found: 404');
  //       Message = '404';
  //       break;
  //     default:
  //   }
  // }
}
