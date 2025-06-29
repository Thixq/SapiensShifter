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
  "payment": "Ödeme",
  "select_all": "Tümünü seç",
  "remove_all": "Tümünü kaldır",
  "date": {
    "week_days": {
      "monday": "Pazartesi",
      "tuesday": "Salı",
      "wednesday": "Çarsamba",
      "thursday": "Perşembe",
      "friday": "Cuma",
      "saturday": "Cumartesi",
      "sunday": "Pazar"
    },
    "today": "Bugün",
    "yesterday": "Dün",
    "tomorrow": "Yarın",
    "day_after_tomorrow": "Yarından Sonra",
    "last_week": "Geçen Hafta",
    "next_week": "Gelecek Hafta",
    "week": "Hafta",
    "indexed_week": "{index}. Hafta"
  },
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
    "null_name": "Eksik Veri",
    "null_double": "00.00"
  },
  "validate": {
    "generic": {
      "null_or_empty": "Bu alan boş bırakılamaz."
    },
    "email": {
      "wrong_email_syntax": "Lütfen geçerli e-posta adresi girin.",
      "empty_email": "E-posta girin."
    },
    "password": {
      "empty_passwrod": "Lütfen şifre giriniz.",
      "min_length": "En az 8 haneli şifre giriniz."
    },
    "product_form": {
      "empty_product": "Lütfen ürün adı girin.",
      "empty_product_desc": "Lütfen açıklama girin.",
      "empty_product_price": "Lütfen fiyat girin.",
      "empty_product_category": "Lütfen kategori seçin."
    }
  },
  "all_exception": {
    "default_exception": "Bir hata oluştu: {message}",
    "general_exception": {
      "is_not_initialized": "{instance} başlatılmadı. Önce initialize()'ı çağırın.",
      "list_is_empty": "Liste boş.",
      "empty_key": "Verilen anahtarın bağlamı boş veya bağlanmamış."
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
      "invalid_credential": "Geçersiz Kimlik",
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
      "invalid_path_exception": "Hatalı dosya yolu. Hatalı dosya yolu: {path}",
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
    },
    "tables": {
      "empty_branch": "Henüz bir vardiyan yok. Müdür ile iletişime geçebilirsin. "
    },
    "home": {
      "new_table": "Masa 1"
    },
    "order_detail": {
      "service_type": "Servis"
    },
    "shift": {
      "shift": "Vardiya"
    },
    "settings": {
      "actions_text": {
        "history_order": "Siparişler",
        "new_product": "Yeni Ürün Ekle",
        "price_edit": "Fiyat Güncelle",
        "shift_add": "Vardiya Ekle"
      },
      "image_picker": {
        "camera": "Fotoğraf Çek",
        "gallery": "Galeriden Seç"
      },
      "sign_out": "Çıkış Yap"
    },
    "chat_preview": {
      "chat": "Sohbet"
    },
    "order_history": {
      "order_list": "Siparişler"
    },
    "new_product_add": {
      "add_product": "Ürün Ekle",
      "form": {
        "product_name": "Ürün Adı",
        "product_description": "Ürün Açıklaması",
        "prdouct_price": "Ürün Fiyat",
        "category": "Kategori",
        "extra": "Ekstrlar"
      },
      "suscess_product": "Ürün başarıyla eklendi.",
      "failed_product": "Ürün eklenirken bir hata oluştu. Lütfen tekrar deneyin."
    },
    "product_price_edit": {
      "product_price_edit": "Fiyat düzenleme"
    },
    "sihft_add_view": {
      "shift_add": "Yeni vardiya",
      "choice_people": "Kişi Seçin",
      "branch_and_shift": {
        "branch": "Şube",
        "shift": "Vardiya"
      },
      "show_toast_message": "Vardiya eklendi."
    }
  },
  "branchs": {
    "karakoy": "Karaköy",
    "kanyon": "Kanyon"
  },
  "category": {
    "all": "Hepsi",
    "hot_coffees": "Sıcak Kahveler",
    "sandwiches": "Sandviçler",
    "coffee_beans": "Kahve Çekirdekleri",
    "soft_drink": "Meşrubatlar",
    "dessert": "Tatlılar",
    "herbal_teas": "Bitki Çayları",
    "brewed_coffees": "Demeleme Kahveler",
    "cold_coffees": "Soğuk Kahveler"
  },
  "options": {
    "milk_options": "Süt Seçenekleri",
    "shot_options": "Shot Seçenekleri",
    "milk_jam_options": "Süt Reçeli",
    "milk": {
      "regular_milk": "Normal Süt",
      "lactose_free": "Laktozsuz Süt",
      "almond_milk": "Badem sütü",
      "coconut_milk": "Hindistan Cevizi Sütü",
      "soy_milk": "Soya Sütü",
      "oat_milk": "Yulaf Sütü"
    },
    "shot": {
      "single_shot": "Tek Shot",
      "double_shot": "İki Shot",
      "triple_shot": "Üç Shot"
    },
    "milk_jam": {
      "regular": "Sade",
      "caramel": "Karamel",
      "white_chocolate": "Beyaz Çikolata",
      "chocolate": "Bitter Çikolata"
    }
  },
  "price_operations": {
    "current": "Güncel fiyat",
    "percent_five": "%5",
    "percent_ten": "%10",
    "percent_fifteen": "%15",
    "percent_twenty": "%20",
    "units_one": "1₺",
    "units_five": "5₺",
    "units_ten": "10₺",
    "units_twenty": "20₺",
    "units_thirty": "30₺"
  },
  "shift_status": {
    "opening": "Açılış",
    "opening_service": "Açılış servis",
    "closing": "Kapanış",
    "closing_service": "Kapanış Servis",
    "off_day": "İzinli",
    "full_day": "Tam Gün",
    "intermediary": "Aracı"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"tr": _tr};
}
