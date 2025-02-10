class ExceptionErrorMessages {
  // Private constructor: Bu sınıfın örneği oluşturulamaz.
  ExceptionErrorMessages(this.a);
  late final String a;
  // Hata kodları ile ilgili mesajların saklandığı map.
  static final Map<String, String> _errorMessages = {
    'invalid-email': a,
    'user-disabled': 'Kullanıcı engellendi.',
    'user-not-found': 'Kullanıcı bulunamadı.',
    'wrong-password': 'Yanlış şifre.',
    'email-already-in-use': 'E-posta zaten kullanımda.',
    'weak-password': 'Zayıf şifre.',
    'operation-not-allowed': 'İşlem izin verilmiyor.',
    'too-many-requests': 'Çok fazla istek yapıldı.',
    'requires-recent-login': 'Son giriş gereklidir.',
    'network-request-failed': 'Ağ isteği başarısız oldu.',
    'user-token-expired': 'Kullanıcı token süresi doldu.',
    'invalid-photo-url': 'Geçersiz fotoğraf URL\'si.',
  };

  /// Verilen hata koduna karşılık gelen hata mesajını döner.
  ///
  /// Eğer kod eşleşmesi bulunamazsa, 'Bilinmeyen hata' mesajı döner.
  static String getMessage(String code) {
    return _errorMessages[code] ?? 'Bilinmeyen hata';
  }
}
