import 'dart:io'; // Ortam değişkenleri için

// ConnectorConfig sınıfı
class ConnectorConfig {
  final String region;
  final String connector;
  final String projectId;

  ConnectorConfig(this.region, this.connector, this.projectId);
}

// FirebaseDataConnect sınıfı
class FirebaseDataConnect {
  static FirebaseDataConnect instanceFor({
    required ConnectorConfig connectorConfig,
    required String sdkType,
  }) {
    // Firebase bağlantısı oluşturma (örnek)
    print('Firebase bağlantısı oluşturuluyor...');
    print('Region: ${connectorConfig.region}');
    print('Connector: ${connectorConfig.connector}');
    print('Project ID: ${connectorConfig.projectId}');
    return FirebaseDataConnect();
  }
}

// CallerSDKType sınıfı
class CallerSDKType {
  static const String generated = 'generated';
}

// DefaultConnector sınıfı
class DefaultConnector {
  static late final ConnectorConfig connectorConfig;

  static final DefaultConnector _instance = DefaultConnector._internal();

  final FirebaseDataConnect dataConnect;

  DefaultConnector._internal({FirebaseDataConnect? customDataConnect})
      : dataConnect = customDataConnect ?? _initializeFirebaseConnection();

  static DefaultConnector get instance => _instance;

  static FirebaseDataConnect _initializeFirebaseConnection() {
    try {
      return FirebaseDataConnect.instanceFor(
        connectorConfig: connectorConfig,
        sdkType: CallerSDKType.generated,
      );
    } catch (e) {
      print('Firebase bağlantısı sırasında bir hata oluştu: $e');
      rethrow;
    }
  }

  // Ortam değişkenlerini okuma
  static void initializeConfig() {
    if (Platform.environment.isNotEmpty) {
      // CLI ortamı için ortam değişkenlerini kullan
      connectorConfig = ConnectorConfig(
        Platform.environment['REGION'] ?? 'us-central1',
        Platform.environment['CONNECTOR'] ?? 'default',
        Platform.environment['PROJECT_ID'] ?? 'seytim_staj',
      );
    } else {
      // Ortam değişkenleri yoksa varsayılan değerler
      connectorConfig = ConnectorConfig('us-central1', 'default', 'seytim_staj');
    }
    print('Bağlantı yapılandırması başarıyla yüklendi.');
  }
}

void main() {
  // DefaultConnector yapılandırmasını başlat
  DefaultConnector.initializeConfig();

  // Singleton instance'ı alın
  final connector = DefaultConnector.instance;

  // Bağlantıyı test etmek için
  print('Bağlantı başarıyla oluşturuldu: ${connector.dataConnect}');
}
