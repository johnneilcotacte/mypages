// ignore_for_file: non_constant_identifier_names

class ErrorMessage {
  ErrorMessage({
    required this.errormessage,
  });

  String errormessage;

  factory ErrorMessage.fromJson(Map<String, dynamic> json) => ErrorMessage(
        errormessage: json["message"] as String? ?? '', //change this
      );
}
