abstract class BaseError {
  int code;
  String message;

  String? raw;

  BaseError(this.code, this.message, this.raw);

}
