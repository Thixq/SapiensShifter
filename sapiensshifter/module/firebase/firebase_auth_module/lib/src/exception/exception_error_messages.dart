class ExceptionErrorMessages {
  // Private constructor: Bu sınıfın örneği oluşturulamaz.
  ExceptionErrorMessages._();

  // Hata kodları ile ilgili mesajların saklandığı map.
  static final Map<String, String> _errorMessages = {
    'invalid_email': 'Geçersiz e-posta adresi.',
    'user_disabled': 'Kullanıcı engellendi.',
    'user_not_found': 'Kullanıcı bulunamadı.',
    'wrong_password': 'Yanlış şifre.',
    'email_already_in_use': 'E-posta zaten kullanımda.',
    'weak_password': 'Zayıf şifre.',
    'operation_not_allowed': 'İşlem izin verilmiyor.',
    'too_many_requests': 'Çok fazla istek yapıldı.',
    'requires_recent_login': 'Son giriş gereklidir.',
    'network_request_failed': 'Ağ isteği başarısız oldu.',
    'user_token_expired': 'Kullanıcı token süresi doldu.',
    'invalid_photo_url': 'Geçersiz fotoğraf URL\'si.',
  };

  /// Verilen hata koduna karşılık gelen hata mesajını döner.
  ///
  /// Eğer kod eşleşmesi bulunamazsa, 'Bilinmeyen hata' mesajı döner.
  static String getMessage(String code) {
    return _errorMessages[code] ?? 'Bilinmeyen hata';
  }
}
