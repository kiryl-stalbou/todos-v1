/// Contains all exception's codes used in the app
abstract final class ExceptionsCodes {
  /// * Thrown if there is no user corresponding to the given email.
  static const String firUserNotFound = 'user-not-found';

  /// * Thrown if the supplied auth credential is malformed or has expired.
  static const String firInvalidCredential = 'invalid-credential';

  /// * Thrown if the password is invalid for the given email, or the account corresponding to the email does not have a password set.
  static const String firInvalidPassword = 'wrong-password';

  /// * Thrown if the user doesn't have internet connection.
  static const String firNetworkRequestFailed = 'network-request-failed';

  /// * Thrown if the request can't reach backend.
  static const String firUnavailable = 'unavailable';

  /// * Thrown if there already exists an account with the given email address.
  static const String firEmailOccupied = 'email-already-in-use';

  /// * Thrown if the email address is not valid.
  static const String firInvalidEmail = 'invalid-email';

  /// * Thrown if the password is not strong enough.
  static const String firWeakPassword = 'weak-password';
}
