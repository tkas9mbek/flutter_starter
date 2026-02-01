class RegistrationForm {
  const RegistrationForm({
    required this.name,
    required this.phone,
    required this.password,
    required this.birthday,
  });

  factory RegistrationForm.fromForm(Map<String, dynamic> form) =>
      RegistrationForm(
        name: form[nameField] as String,
        phone: form[phoneField] as String,
        password: form[passwordField] as String,
        birthday: form[birthdayField] as DateTime,
      );

  static const String nameField = 'name';
  static const String phoneField = 'phone';
  static const String passwordField = 'password';
  static const String birthdayField = 'birthday';

  final String name;
  final String phone;
  final String password;
  final DateTime birthday;
}
