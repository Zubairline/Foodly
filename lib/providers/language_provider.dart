import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/language_picker.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en'); // Default to English

  Language _selectedDropdownLanguage = Languages.english;
  Language _selectedDialogLanguage = Languages.english;
  Language _selectedCupertinoLanguage = Languages.english;

  Locale get locale => _locale;

  Language get selectedDropdownLanguage => _selectedDropdownLanguage;
  Language get selectedDialogLanguage => _selectedDialogLanguage;
  Language get selectedCupertinoLanguage => _selectedCupertinoLanguage;

  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }

  // Helper method to get language name
  String getLanguageName() {
    switch (_locale.languageCode) {
      case 'en':
        return 'English';
      case 'es':
        return 'Spanish';
      case 'fr':
        return 'French';
      case 'de':
        return 'German';
      default:
        return 'English';
    }
  }

  // It's sample code of Dropdown Item.
  Widget buildDropdownItem(Language language) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 8.0),
        Text("${language.name} (${language.isoCode})"),
      ],
    );
  }

  // It's sample code of Dialog Item.
  Widget buildDialogItem(Language language) => Row(
    children: <Widget>[
      Text(language.name),
      const SizedBox(width: 8.0),
      Flexible(child: Text("(${language.isoCode})")),
    ],
  );

  void openLanguagePickerDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(primaryColor: const Color(0xFFEB7A50)),
      child: LanguagePickerDialog(
        titlePadding: const EdgeInsets.all(8.0),
        searchCursorColor: const Color(0xFFEB7A50),
        searchInputDecoration: const InputDecoration(hintText: 'Search...'),
        isSearchable: true,
        title: const Text('Select your language'),
        onValuePicked: (Language language) {
          _selectedDialogLanguage = language;
          setLocale(Locale(language.isoCode));
          print(_selectedDialogLanguage.name);
          print(_selectedDialogLanguage.isoCode);
          notifyListeners();
        },
        itemBuilder: buildDialogItem,
      ),
    ),
  );

  // It's sample code of Cupertino Item.
  void openCupertinoLanguagePicker(BuildContext context) =>
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return LanguagePickerCupertino(
            pickerSheetHeight: 200.0,
            onValuePicked: (Language language) {
              _selectedCupertinoLanguage = language;
              setLocale(Locale(language.isoCode));
              print(_selectedCupertinoLanguage.name);
              print(_selectedCupertinoLanguage.isoCode);
              notifyListeners();
            },
          );
        },
      );

  Widget buildCupertinoItem(Language language) => Row(
    children: <Widget>[
      Text("+${language.name}"),
      const SizedBox(width: 8.0),
      Flexible(child: Text(language.name)),
    ],
  );

  void onDropdownValuePicked(Language language) {
    _selectedDropdownLanguage = language;
    setLocale(Locale(language.isoCode));
    print(_selectedDropdownLanguage.name);
    print(_selectedDropdownLanguage.isoCode);
    notifyListeners();
  }
}
