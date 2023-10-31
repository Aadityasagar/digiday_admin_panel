class ApiException  implements Exception {
  String? message;
  int? status;
  String? redirectionURL;
  ApiException({this.message,this.status,this.redirectionURL});

  @override
  String toString(){
    return 'ApiException : {status: $status, message: $message}';
  }
}

class ApiExceptionCode{
  static const int noDocument = -10001;
  static const int documentDeleted = -228;
  static const int sessionExpire = 440;
  static const int invalidAccessToken = -27;
}