class AppConfig {
  static const String defaultLocalUrl = 'http://192.168.0.9:5000';
  static const String defaultCloudUrl = 'https://obratech-y040.onrender.com';

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: defaultCloudUrl,
  );
}