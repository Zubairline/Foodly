// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get settings => 'Einstellungen';

  @override
  String get accountSettings => 'Kontoeinstellungen';

  @override
  String get language => 'Sprache';

  @override
  String get clearHistory => 'Verlauf löschen';

  @override
  String get feedback => 'Feedback';

  @override
  String get checkForNewVersion => 'Nach neuen Versionen suchen';

  @override
  String get mode => 'Modus';

  @override
  String get darkMode => 'Dunkler Modus';

  @override
  String get logout => 'Abmelden';

  @override
  String get notificationsEnabled => 'Benachrichtigungen aktiviert';

  @override
  String get notificationsDisabled => 'Benachrichtigungen deaktiviert';

  @override
  String languageChanged(Object language) {
    return 'Sprache geändert zu $language';
  }

  @override
  String get historyCleared => 'Verlauf gelöscht';

  @override
  String get feedbackSent => 'Feedback gesendet';

  @override
  String get appUpToDate => 'App ist auf dem neuesten Stand';

  @override
  String get darkModeEnabled => 'Dunkler Modus aktiviert';

  @override
  String get darkModeDisabled => 'Dunkler Modus deaktiviert';

  @override
  String get feedbackRequired => 'Bitte geben Sie Ihr Feedback';

  @override
  String get feedbackSubmitted => 'Vielen Dank für Ihr Feedback!';

  @override
  String get rateApp => 'Bewerten Sie unsere App';

  @override
  String get shareOpinion => 'Teilen Sie Ihre Meinung';

  @override
  String get feedbackHint => 'Sagen Sie uns, was Sie von der App halten...';

  @override
  String get appPerformance => 'Wie würden Sie die Leistung der App bewerten?';

  @override
  String get excellent => 'Ausgezeichnet';

  @override
  String get good => 'Gut';

  @override
  String get average => 'Durchschnittlich';

  @override
  String get poor => 'Schlecht';

  @override
  String get veryPoor => 'Sehr schlecht';

  @override
  String get submitFeedback => 'Feedback senden';
}
