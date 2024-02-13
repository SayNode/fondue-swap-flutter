class ContractCallRevertedException implements Exception {
  ContractCallRevertedException(this.cause);
  String cause;
}

class InvalidDataInContractException implements Exception {
  InvalidDataInContractException(this.cause);
  String cause;
}
