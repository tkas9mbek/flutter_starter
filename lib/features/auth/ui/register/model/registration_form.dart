class RegistrationForm {
  static const String passwordField = 'password';
  static const String phoneField = 'phone';

  const RegistrationForm({
    required this.password,
    required this.phone,
  });

  final String password;
  final String phone;

  factory RegistrationForm.fromForm(Map<String, dynamic> form) {
    return RegistrationForm(
      password: form[passwordField] as String,
      phone: form[phoneField] as String,
    );
  }
}
