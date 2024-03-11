class PasswordCriteria {
  PasswordCriteria(
    this.name,
    this.strength,
    this.validateFunction, {
    required this.validated,
  });
  final String name;
  final int strength;
  final bool Function(String) validateFunction;
  bool validated;

  int validate(String password) {
    return (validated = validateFunction(password)) ? strength : 0;
  }
}
