class ContractCallRevertedException implements Exception {
  ContractCallRevertedException(this.cause);
  String cause;
}

class InvalidDataInContractException implements Exception {
  InvalidDataInContractException(this.cause);
  String cause;
}

class NoPoolFoundException implements Exception {
  NoPoolFoundException(this.cause);
  String cause;
}

class NotEnoughLiquidityException implements Exception {
  NotEnoughLiquidityException(this.cause);
  String cause;
}
