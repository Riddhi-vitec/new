
class AppEnvironmentVariables{
  static const baseURL = "base-url";
  static const baseWebURL = "base-web-url";
  static const appName = "app-name";
  static const appTitle = "app-title";
  static const debugBannerBoolean = "debug-banner-boolean";
  static const socketUrl = "socket-url";
  static const  stripePublishableKey = "stripe-publishable-key";
  static const iOSBundleID = "iOSBundleID";

  //make necessary changes
  static Map<String, dynamic> dev = {
    baseURL: "https://template.vitec-visual-dev.com/api",
    baseWebURL: "https://vitec-dev.com",
    appName:'Vitec Bloc Template Dev',
    debugBannerBoolean: true,
    appTitle: 'Vitec Bloc Template Dev',
    socketUrl: 'socket.io.dev',
    stripePublishableKey: 'pk_test_51OBsTFLFLkNaEB4UcHJ1fOr2Uisetr8y2QrVA5qPLbNgA4Yn78twZKkB1RQH4jZjEiBEdKndANzOk5unpDKxEDEq00XRtUibDjsk_test_51OBsTFLFLkNaEB4Uy9R9QGHtPeB1B7ojDasjR4AIfS3A26W4dVJyuXQZijnIbVuK4Okqu5JHFgeO82nayoBLkEeg00tbw7z534',
    iOSBundleID: 'com.vitecvisual.fluttertemplates.dev'
  };

  //make necessary changes
  static Map<String, dynamic> prod = {
    baseURL: "https://template.vitec-visual-dev.com/api",
    baseWebURL: "https://vitec-prod.com",
    appName:'Vitec Bloc Template',
    debugBannerBoolean: false,
    appTitle: 'Vitec Bloc Template',
    socketUrl: 'socket.io.dev',
    stripePublishableKey: 'ASK FROM BE',
    iOSBundleID: 'com.vitecvisual.fluttertemplates'
  };
}