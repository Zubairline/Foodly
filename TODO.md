# TODO: Replace Language Provider with BLoC

## Steps to Complete

- [x] Create lib/blocs/language_bloc.dart with LanguageBloc, events (e.g., ChangeLanguage), and state (LanguageState with locale and selected languages).
- [x] Update lib/main.dart to use BlocProvider<LanguageBloc> instead of ChangeNotifierProvider.
- [x] Update lib/screens/settings.dart to use BlocBuilder for the language dropdown and context.read<LanguageBloc>().add(ChangeLanguage(language)) for updates.
- [x] Remove lib/providers/language_provider.dart.
- [x] Update imports in affected files.

## Followup Steps

- [x] Test the app to ensure language switching works correctly.
- [x] Run the app and verify no errors.
