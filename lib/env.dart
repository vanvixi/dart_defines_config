class Env {
  const Env();

  static const envName = String.fromEnvironment('ENV');
  static const appName = String.fromEnvironment('APP_NAME');

  static bool isProdMode = Env.envName.toUpperCase() == 'PROD';
}
