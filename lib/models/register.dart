class Register {
  String status;
  String message;

  Register({
    required this.status,
    required this.message,
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      status: json['status'],
      message: json['message'],
    );
  }
}
