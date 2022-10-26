class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'en_US': Locales.en_US,
    'id_ID': Locales.id_ID,
  };
}

class LocaleKeys {
  LocaleKeys._();
  static const buttons_login = 'buttons_login';
  static const buttons_sign_in = 'buttons_sign_in';
  static const buttons_logout = 'buttons_logout';
  static const buttons_rememberme = 'buttons_rememberme';
  static const message_confirm_change_user = 'message_confirm_change_user';
}

class Locales {
  static const en_US = {
    'buttons_login': 'Login',
    'buttons_sign_in': 'Sign-in',
    'buttons_logout': 'Logout',
    'buttons_rememberme': 'Remember Me',
    'message_confirm_change_user': 'Ada perubahan login, login sebagai @userid ?',
  };
  static const id_ID = {
    'buttons_login': 'Masuk',
    'buttons_sign_in': 'Sign-in',
    'buttons_logout': 'Keluar',
    'buttons_rememberme': 'Ingat Kata Kunci',
  };
}
