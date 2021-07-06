class Language {
  static const String it = 'it';
  static const String en = 'en';
  static const String es = 'es';

  static Map<String, String> load(String lang) {
    switch (lang) {
      case it:
        return itStrings;
        break;
      case es:
        return esStrings;
        break;
      case en:
        return enStrings;
        break;
      default:
        return enStrings;
        break;
    }
  }

  static Map<String, String> enStrings = {
    "welcome": "welcome",
    "hello": "hello",
    "name": "Name"
  };
  static Map<String, String> esStrings = {
    "welcome": "bienvenido",
    "hello": "hola",
  };
  static Map<String, String> itStrings = {
    "welcome": "benvenuto",
    "hello": "ciao",
    "name": "Nome"
  };
}
