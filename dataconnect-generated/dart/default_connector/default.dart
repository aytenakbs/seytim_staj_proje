import 'dart:convert';
import 'dart:io'; // Ortam değişkenleri için gerekli

class DefaultConnector {
  // Statik yapılandırma tanımı (Ortam değişkenlerinden değerler alınıyor)
  static final ConnectorConfig connectorConfig = ConnectorConfig(
    Platform.environment['REGION'] ?? 'us-central1',
    Platform.environment['CONNECTOR'] ?? 'default',
    Platform.environment['PROJECT_ID'] ?? 'seytim_staj',
  );

  // Singleton (Tekil) instance tanımı
  static final DefaultConnector _instance = DefaultConnector._internal();

  // Firebase bağlantısı
  final FirebaseDataConnect dataConnect;

  // Özel bir constructor (statik instance ile ilişkili)
  DefaultConnector._internal({FirebaseDataConnect? customDataConnect})
      : dataConnect = customDataConnect ??
      _initializeFirebaseConnection();

  // Singleton instance döndürme
  static DefaultConnector get instance => _instance;

  // Firebase bağlantısı oluşturma (Hata yönetimi ile birlikte)
  static FirebaseDataConnect _initializeFirebaseConnection() {
    try {
      return FirebaseDataConnect.instanceFor(
        connectorConfig: connectorConfig,
        sdkType: CallerSDKType.generated,
      );
    } catch (e) {
      // Hata yönetimi
      print('Firebase bağlantısı sırasında bir hata oluştu: $e');
      rethrow;
    }
  }
}
