
import '../../imports/common.dart';
import '../../imports/services.dart';
import '../../imports/usecase.dart';


class StripeTokenDataService {
  Future createStripeToken(
      StripeTokenUseCaseInput caseInput) async {
    String baseUrl = UrlPrefixes.stripeTokenUrl;
    Map<String, dynamic> data = {
      "card[number]": caseInput.cardNumber,
      "card[exp_month]": caseInput.expiryMonth,
      "card[exp_year]": caseInput.expiryYear,
      "card[cvc]": caseInput.cvc,
      "card[name]": caseInput.cardHolderName
    };

    final response = await HttpServices.postMethod(baseUrl,
        data: data,
        header: await setHeader(false, isStripeTokenRequired: true));
    return response;
  }
}
