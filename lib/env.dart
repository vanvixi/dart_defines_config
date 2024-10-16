import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:trimo/app/configs/api_config/api_config.dart';

///  use it:
///
/// ```dart
/// flutter run --dart-define=ENV=dev --dart-define=BASE_URL=https://api.com
/// ```
///

///
/// Environment(Dart Define)
///
const String kEnv = 'ENV';
const String kWebURL = 'WEB_URL';
const String kBaseUrlEnv = 'BASE_URL';
const String kSocketUrlEnv = 'SOCKET_URL';
const String kBaseUrlS3Env = 'BASE_URL_S3';
const String kDebugBannerTitleEnv = 'DEBUG_BANNER_TITLE';
const String kDebugBannerColorEnv = 'DEBUG_BANNER_COLOR';
const String kAppStoreUrl = 'APP_STORE_URL';
const String kGooglePlayStoreUrl = 'GOOGLE_PLAY_STORE_URL';
const String kMapBoxToken = 'MAPBOX_TOKEN';
const String kGoogleMapToken = 'GOOGLE_MAP_TOKEN';
const String kAppsFlyerKey = 'APPS_FLYER_KEY';
const String kAppsFlyerTemplateLink = 'APPS_FLYER_TEMPLATE_LINK';
const String kAppLink2 = 'APP_LINK_2';

class Env {
  const Env();

  static const envName = String.fromEnvironment(kEnv);
  static const mapBoxToken = String.fromEnvironment(kMapBoxToken);
  static const googleMapToken = String.fromEnvironment(kGoogleMapToken);
  static const appsFlyerKey = String.fromEnvironment(kAppsFlyerKey);
  static const appLink2 = String.fromEnvironment(kAppLink2);
  static const appsFlyerTemplateLink = String.fromEnvironment(kAppsFlyerTemplateLink);

  static const appIdAndroid = 'app.recago.videoapp';
  static const appIdIOS = '6451781384';

  static late String appId;

  static void ensureInitialized() {
    _configBaseUrl();
    _configFlavor();
    appId = _getAppId();
  }

  static bool get isProdMode => Env.envName.toUpperCase() == 'PROD';

  /// Base URL
  static void _configBaseUrl() {
    BaseUrlConfig(
      webUrl: const String.fromEnvironment(kWebURL),
      url: const String.fromEnvironment(kBaseUrlEnv),
      s3Url: const String.fromEnvironment(kBaseUrlS3Env),
      storeUrl: _getStoreUrlFromEnv(),
      socketUrl: const String.fromEnvironment(kSocketUrlEnv),
    );
  }

  /// URL of application distribution
  static String _getStoreUrlFromEnv() {
    if (Platform.isAndroid) return const String.fromEnvironment(kGooglePlayStoreUrl);
    if (Platform.isIOS) return const String.fromEnvironment(kAppStoreUrl);

    return '';
  }

  /// App ID
  static String _getAppId() {
    if (Platform.isAndroid) return appIdAndroid;
    if (Platform.isIOS) return appIdIOS;

    return '';
  }

  /// Flavor
  static void _configFlavor() {
    /// App banner color
    final bannerColor = int.tryParse(const String.fromEnvironment(kDebugBannerColorEnv));

    /// App banner (environmental judgment) settings
    FlavorConfig(
      name: const String.fromEnvironment(kDebugBannerTitleEnv),
      color: Color(bannerColor ?? 0x00000000),
      location: BannerLocation.bottomStart,
    );
  }
}
