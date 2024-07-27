class ServerException implements Exception {
  final String message;
  final String? code;
  ServerException({required this.message, this.code});

  @override
  String toString() {
    return message;
  }
}

class CacheException implements Exception {
  final String message;
  final String? code;

  CacheException({required this.message,  this.code});
}
