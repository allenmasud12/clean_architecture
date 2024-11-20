enum LanguageType {ENGLISH, BANGLA}
const String BANGLA = "bn";
const String ENGLISH = "en";
extension LanguageTypeExtension on LanguageType{
  String getValue(){
    switch (this){
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.BANGLA:
        return BANGLA;
    }
  }
}