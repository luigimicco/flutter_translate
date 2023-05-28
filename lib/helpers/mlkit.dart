import 'package:flutter/foundation.dart';
import 'package:flutter_translate/models/language_model.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';

class MLHelper {
  Future<List<LanguageModel>> identifyLanguage(String text) async {
    List<LanguageModel> result = [];
    final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.3);
    final List<IdentifiedLanguage> languages =
        await languageIdentifier.identifyPossibleLanguages(text);
    try {
      for (IdentifiedLanguage language in languages) {
        result.add(LanguageModel(
            text: language.languageTag, confidence: language.confidence));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return result;
  }
}
