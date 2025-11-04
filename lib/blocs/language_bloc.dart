import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/language_picker.dart';

abstract class LanguageEvent {}

class ChangeLanguage extends LanguageEvent {
  final Language language;

  ChangeLanguage(this.language);
}

class LanguageState {
  final Locale locale;
  final Language selectedDropdownLanguage;
  final Language selectedDialogLanguage;
  final Language selectedCupertinoLanguage;

  LanguageState({
    required this.locale,
    required this.selectedDropdownLanguage,
    required this.selectedDialogLanguage,
    required this.selectedCupertinoLanguage,
  });

  LanguageState copyWith({
    Locale? locale,
    Language? selectedDropdownLanguage,
    Language? selectedDialogLanguage,
    Language? selectedCupertinoLanguage,
  }) {
    return LanguageState(
      locale: locale ?? this.locale,
      selectedDropdownLanguage:
          selectedDropdownLanguage ?? this.selectedDropdownLanguage,
      selectedDialogLanguage:
          selectedDialogLanguage ?? this.selectedDialogLanguage,
      selectedCupertinoLanguage:
          selectedCupertinoLanguage ?? this.selectedCupertinoLanguage,
    );
  }
}

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc()
    : super(
        LanguageState(
          locale: const Locale('en'),
          selectedDropdownLanguage: Languages.english,
          selectedDialogLanguage: Languages.english,
          selectedCupertinoLanguage: Languages.english,
        ),
      ) {
    on<ChangeLanguage>(_onChangeLanguage);
  }

  void _onChangeLanguage(ChangeLanguage event, Emitter<LanguageState> emit) {
    emit(
      state.copyWith(
        locale: Locale(event.language.isoCode),
        selectedDropdownLanguage: event.language,
        selectedDialogLanguage: event.language,
        selectedCupertinoLanguage: event.language,
      ),
    );
  }

  // Helper method to get language name
  String getLanguageName() {
    switch (state.locale.languageCode) {
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
          add(ChangeLanguage(language));
          print(language.name);
          print(language.isoCode);
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
              add(ChangeLanguage(language));
              print(language.name);
              print(language.isoCode);
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
}
