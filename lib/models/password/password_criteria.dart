class PasswordCriteria {
  final String name;
  final int strength;
  final bool Function(String) validateFunction;
  bool validated;

  PasswordCriteria(
    this.name,
    this.strength,
    this.validateFunction,
    this.validated,
  );

  int validate(String password) {
    return (validated = validateFunction(password)) ? strength : 0;
  }
}
