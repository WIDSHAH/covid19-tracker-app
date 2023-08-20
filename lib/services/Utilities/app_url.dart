class AppUrl {
  // This is our base Url
  static const String baseUrl = 'http://disease.sh/v3/covid-19/';

  // Fetch world covid states
  static const String worldStatesApi = baseUrl + 'all';
  static const String countriesList = baseUrl + 'countries';
}