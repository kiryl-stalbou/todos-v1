import '../exceptions/exceptions_codes.dart';

/// App Localizations Keys
abstract final class Lk {
  static String forCode(String code) => switch (code) {
        ExceptionsCodes.firInvalidPassword => Lk.errorInvalidPassword,
        ExceptionsCodes.firUserNotFound => Lk.errorUserNotFound,
        ExceptionsCodes.firInvalidCredential => Lk.errorInvalidCredential,
        ExceptionsCodes.firUnavailable => Lk.errorBadInternet,
        ExceptionsCodes.firNetworkRequestFailed => Lk.errorBadInternet,
        ExceptionsCodes.firWeakPassword => Lk.errorWeakPassword,
        ExceptionsCodes.firEmailOccupied => Lk.errorEmailOccupied,
        _ => Lk.errorUnknown,
      };

  static const String all = 'all';
  static const String pickDate = 'pickDate';
  static const String addTodo = 'addTodo';
  static const String title = 'title';
  static const String notes = 'notes';
  static const String today = 'today';
  static const String completed = 'completed';
  static const String profile = 'profile';
  static const String toggleLanguage = 'toggleLanguage';
  static const String ok = 'ok';
  static const String signout = 'signout';
  static const String toggleTheme = 'toggleTheme';
  static const String email = 'email';
  static const String password = 'password';
  static const String name = 'name';
  static const String tryAgain = 'tryAgain';
  static const String proceed = 'proceed';
  static const String cancel = 'cancel';
  static const String require = 'require';
  static const String restoreMode = 'restoreMode';
  static const String dragMode = 'dragMode';
  static const String deleteMode = 'deleteMode';
  static const String addDate = 'addDate';
  static const String search = 'search';

  static const String signin = 'signin';
  static const String signinButton = 'signinButton';
  static const String signinActive = 'signinActive';
  static const String signinSuccess = 'signinSuccess';
  static const String signinFailed = 'signinFailed';

  static const String signup = 'signup';
  static const String signupButton = 'signupButton';
  static const String signupActive = 'signupActive';
  static const String signupSuccess = 'signupSuccess';
  static const String signupFailed = 'signupFailed';

  static const String signinDontHaveAcc = 'signinDontHaveAcc';
  static const String signupHaveAcc = 'signupHaveAcc';

  static const String errorInvalidEmail = 'errorInvalidEmail';

  static const String scopeInitErrorTitle = 'scopeInitErrorTitle';
  static const String scopeInitErrorSubtitle = 'scopeInitErrorSubtitle';

  static const String profileSignOutActive = 'profileSignOutActive';
  static const String profileSignOutSuccess = 'profileSignOutSuccess';
  static const String profileSignOutFailed = 'profileSignOutFailed';

  static const String errorInvalidCredential = 'errorInvalidCredential';
  static const String errorUserNotFound = 'errorUserNotFound';
  static const String errorInvalidPassword = 'errorInvalidPassword';
  static const String errorWeakPassword = 'errorWeakPassword';
  static const String errorEmailOccupied = 'errorEmailOccupied';
  static const String errorBadInternet = 'errorBadInternet';
  static const String errorReleaseTitle = 'errorReleaseTitle';
  static const String errorReleaseBody = 'errorReleaseBody';
  static const String errorUnknown = 'errorUnknown';
  static const String errorUnexpectedTitle = 'errorUnexpectedTitle';
}
