class RegistrationForm {
  static const String nameField = 'name';
  static const String phoneField = 'phone';
  static const String passwordField = 'password';
  static const String birthdayField = 'birthday';

  const RegistrationForm({
    required this.name,
    required this.phone,
    required this.password,
    required this.birthday,
  });

  final String name;
  final String phone;
  final String password;
  final DateTime birthday;

  factory RegistrationForm.fromForm(Map<String, dynamic> form) {
    return RegistrationForm(
      name: form[nameField] as String,
      phone: form[phoneField] as String,
      password: form[passwordField] as String,
      birthday: form[birthdayField] as DateTime,
    );
  }
}
