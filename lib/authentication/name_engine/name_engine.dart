import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class NameEngine {
  static Future<String> get createUserName async {
    List<String> adjectives = [];
    List<String> nouns = [];
    String theAdjective = 'funny';
    String theNoun = 'person';
    try {
      final adjectiveUrl = Uri.parse(
          'https://ydtwo-8550b-default-rtdb.firebaseio.com/words/adjectives.json');
      final nounUrl = Uri.parse(
          'https://ydtwo-8550b-default-rtdb.firebaseio.com/words/nouns.json');
      final adjectiveResponse = await http.get(adjectiveUrl);
      final nounResponse = await http.get(nounUrl);

      final adjectiveData = json.decode(adjectiveResponse.body);
      final nounData = json.decode(nounResponse.body);
      if (adjectiveData != null) {
        adjectives = List.castFrom(adjectiveData);
      }
      if (nounData != null) {
        nouns = List.castFrom(nounData);
      }
      adjectives = List.castFrom(json.decode(adjectiveResponse.body));
      nouns = List.castFrom(json.decode(nounResponse.body));
      theAdjective = adjectives[Random().nextInt(adjectives.length)];
      theNoun = nouns[Random().nextInt(nouns.length)];
    } catch (e) {
      rethrow;
    }

    return '$theAdjective$theNoun';
  }
}
