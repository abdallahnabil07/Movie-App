class ResponseDataModel {
  final String message;
  final String data;

  ResponseDataModel({required this.message, required this.data});

  factory ResponseDataModel.fromJson(Map<String, dynamic> json) {
    return ResponseDataModel(message: json['message'], data: json['data']);
  }
}
