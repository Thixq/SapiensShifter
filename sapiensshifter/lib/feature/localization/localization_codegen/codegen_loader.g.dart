// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> tr = {
  "price_symbol": "₺",
  "confirm": "Onayla",
  "delete": "Sil",
  "empty_items": "Boş Liste",
  "drop_down": {
    "drop_down_default": "Seçiniz",
    "drop_down_extra": "Ekstra Seçiniz"
  },
  "order_info_bottom_sheet": {
    "table_delete": "Masayı Sil",
    "new_order": "Ürün Ekle",
    "total": "Toplam: {price}₺"
  },
  "null_value": {
    "null_name": "Eksik Ve Hatalı",
    "null_double": "00.00"
  },
  "all_exception": {
    "default_exception": "Bir hata oluştu: {message}",
    "local_cache_exception": {
      "expected_type": "Anahtar için değer türü uyumsuzluğu: {key}. Beklenen: {expectedType}, Bulunan: {actualType}",
      "not_found_key": "{key} anahtarı için değer bulunamadı",
      "un_supported_value": "Desteklenmeyen değer türü: {valueType}"
    },
    "firebase_auth_exception": {
      "invalid_email": "Geçersiz bir e-posta adresi girdiniz.",
      "user_disabled": "Bu kullanıcı devre dışı bırakılmış.",
      "user_not_found": "Bu e-posta adresiyle ilişkili bir kullanıcı bulunamadı.",
      "wrong_password": "Hatalı şifre girdiniz.",
      "email_already_use": "Bu e-posta adresi zaten bir hesapla ilişkilendirilmiş.",
      "weak_password": "Şifre çok zayıf. Lütfen daha güçlü bir şifre seçin.",
      "requires_recent_login": "Bu işlem yakın zamanda giriş yapmayı gerektirir. Lütfen tekrar giriş yapın.",
      "network_request_failed": "Ağ hatası. Lütfen internet bağlantınızı kontrol edin.",
      "user_token_expired": "Oturumunuz sona erdi. Lütfen tekrar giriş yapın.",
      "invalid_photo_url": "Verilen fotoğraf URL'si geçersiz.",
      "operation_not_allowed": "Bu işlem şu anda desteklenmiyor.",
      "too_many_requests": "Çok fazla istek gönderildi. Lütfen daha sonra tekrar deneyin."
    }
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"tr": tr};
}
