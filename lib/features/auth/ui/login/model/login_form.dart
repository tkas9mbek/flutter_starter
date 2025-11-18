class LoginForm {
  static const String passwordField = 'password';
  static const String phoneField = 'phone';

  const LoginForm({
    required this.password,
    required this.phone,
  });

  final String password;
  final String phone;

  factory LoginForm.fromForm(Map<String, dynamic> form) => LoginForm(
        password: form[passwordField] as String,
        phone: form[phoneField] as String,
      );
}
