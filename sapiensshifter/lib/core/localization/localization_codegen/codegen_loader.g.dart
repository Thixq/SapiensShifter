// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _tr = {
  "coffee_sapiens": "Coffe Sapiens",
  "price_symbol": "₺",
  "confirm": "Onayla",
  "delete": "Sil",
  "empty_items": "Boş Liste",
  "next": "Devam",
  "previous": "Geri",
  "done": "Tamam",
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
  "validate": {
    "email": {
      "wrong_email_syntax": "Lütfen geçerli e-posta adresi girin.",
      "empty_email": "E-posta girin."
    },
    "password": {
      "empty_passwrod": "Lütfen şifre giriniz.",
      "min_length": "En az 8 haneli şifre giriniz."
    }
  },
  "all_exception": {
    "default_exception": "Bir hata oluştu: {message}",
    "generic_exception": {
      "is_not_initialized": "{instance} başlatılmadı. Önce initialize()'ı çağırın."
    },
    "network_error_exception": {
      "no_network_connection": "İnternet bağlantısı yok. İnternet bağlantınızı kontrol edin."
    },
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
      "email_already_in_use": "Bu e-posta adresi zaten bir hesapla ilişkilendirilmiş.",
      "weak_password": "Şifre çok zayıf. Lütfen daha güçlü bir şifre seçin.",
      "requires_recent_login": "Bu işlem yakın zamanda giriş yapmayı gerektirir. Lütfen tekrar giriş yapın.",
      "network_request_failed": "Ağ hatası. Lütfen internet bağlantınızı kontrol edin.",
      "user_token_expired": "Oturumunuz sona erdi. Lütfen tekrar giriş yapın.",
      "invalid_photo_url": "Verilen fotoğraf URL'si geçersiz.",
      "operation_not_allowed": "Bu işlem şu anda desteklenmiyor.",
      "too_many_requests": "Çok fazla istek gönderildi. Lütfen daha sonra tekrar deneyin."
    },
    "firebase_firestore_exception": {
      "invalid_path_exception": "Hatalı dosya yolu.",
      "batch_commit_exception": "Bazı belgelerde hatta oluştu. Ayrıntılar: {failedDocs}",
      "document_data_exception": "Belgeden gelen veri boş. Belge yolu: {path}",
      "document_not_found_exception": "Belge bulunamadı. Belge yolu: {path}"
    },
    "social_credential_exception": {
      "failed_credential": "{social} ile oturum açılamadı: {error}",
      "canceled_user": "Oturum açma işlemi kullanıcı tarafından iptal edildi."
    }
  },
  "page": {
    "onboard": {
      "onboard_content": {
        "content_title": {
          "order": "Sipariş",
          "shift": "Vardiya",
          "warehouse": "Depo"
        },
        "content_desc": {
          "order_desc": "Şiparişleri Sapiens Shifter uygulaması ile alabilirsin.",
          "shift_desc": "Vardiyalarını haftalık olarak takip edebilirisin. Yeni vardiyların için bildirim alabilirsin.",
          "warehouse_desc": "Şublerin ihtiyaçlarını Sapiens Shifter üzerinden geçebilirsin. İş arkadaşların ile iş hakkında sohbet edebilirsin."
        }
      }
    },
    "sign": {
      "email": "E-posta",
      "password": "Şifre",
      "username": "Ad",
      "sign_in": {
        "recovery_password": "Şifremi Unuttum",
        "sign_in": "Giriş Yap",
        "or": "ya da",
        "not_a_member": "Üye değil misiniz? ",
        "register_now": "Hemen üye olun!"
      },
      "register": {
        "registerText": "Kayıt Ol",
        "member": "Üye misiniz? ",
        "sign_in": "Giriş yapın!"
      }
    }
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"tr": _tr};
}
