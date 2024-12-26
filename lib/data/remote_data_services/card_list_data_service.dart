import 'package:flutter/services.dart';

class CardListDataService{

  @override
 static Future fetchCardList() async {
    final String jsonString = await rootBundle.loadString('assets/mock_json/card_list.json');
    return jsonString;
  }
}