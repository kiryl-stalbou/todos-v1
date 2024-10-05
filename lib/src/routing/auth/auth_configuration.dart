final class AuthConfiguration {
  const AuthConfiguration({required this.showSignUp});

  const AuthConfiguration.signIn() : showSignUp = false;
  const AuthConfiguration.signUp() : showSignUp = true;

  factory AuthConfiguration.fromUri(Uri uri) {
    if (uri.pathSegments.isNotEmpty && uri.pathSegments[0] == 'signup') {
      return const AuthConfiguration.signUp();
    }

    return const AuthConfiguration.signIn();
  }

  final bool showSignUp;

  Uri toUri() => Uri.parse(showSignUp ? '/signup' : '/signin');

  @override
  String toString() => 'AuthConfig(showSignUp: $showSignUp)';
}
