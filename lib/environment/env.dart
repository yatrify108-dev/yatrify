enum AppEnvironment { dev, prod }

class EnvironmentConfig {
  static AppEnvironment current = AppEnvironment.dev;

  static bool get isDev => current == AppEnvironment.dev;
  static bool get isProd => current == AppEnvironment.prod;
}
