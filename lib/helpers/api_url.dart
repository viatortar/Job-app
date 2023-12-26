class ApiUrl {
  // domain nya sesuaiin hotspot (ip private yang laptop dapetin)
  static const String baseUrl = 'http://10.0.2.2/toko-api/public';

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listLowongan = baseUrl + '/lowongan';
  static const String createLowongan = baseUrl + '/lowongan';

  static String updateLowongan(int id) {
    return baseUrl + '/lowongan/' + id.toString() + '/update';
  }

  static String showLowongan(int id) {
    return baseUrl + '/lowongan/' + id.toString();
  }

  static String deleteLowongan(int id) {
    return baseUrl + '/lowongan/' + id.toString();
  }
}
