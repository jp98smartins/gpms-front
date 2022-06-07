/// Verifies if the value of TextField is empty
String? validatorEmpty(
  String? value, {
  bool isDense = false,
}) {
  if (value == null || value.trim() == '' || value == "null") {
    return isDense ? 'Obrigatório!' : 'Esse campo é obrigatório!';
  }
  return null;
}
