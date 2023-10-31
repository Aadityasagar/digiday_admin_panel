class ApiResponse<T> {
  String? message;
  int? code;
  dynamic data;


  ApiResponse({this.message, this.code, this.data});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    try {
      if (json['data'] is List) {
        data = json['data'] as List;
      } else if (json['data'] is Map) {
        data = json['data'] as Map;
      } else if (json['data'] is String) {
        data = json['data'] as String;
      }
    } catch (e) {
      print("Exception ${e}");
    }
  }

  @override
  String toString() {
    return 'Code: $code, Message: $message, Data: $data';
  }
}
