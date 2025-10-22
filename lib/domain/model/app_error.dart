class AppError implements Exception {
  final AppErrorType errorType;
  AppError(this.errorType);

  @override
  String toString() => 'AppError: ${errorType.name}';
}

enum AppErrorType {
  noInternet,
  rateLimitExceeded,
  timeOut,
  serverError,
  badRequest,
  unknown,
}