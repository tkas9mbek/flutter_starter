class LoginForm {
  const LoginForm({required this.password, required this.phone});

  factory LoginForm.fromForm(Map<String, dynamic> form) => LoginForm(
    password: form[passwordField] as String,
    phone: form[phoneField] as String,
  );

  static const String passwordField = 'password';
  static const String phoneField = 'phone';

  final String password;
  final String phone;
}
