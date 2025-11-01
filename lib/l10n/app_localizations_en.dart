// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settings => 'Settings';

  @override
  String get accountSettings => 'Account Settings';

  @override
  String get language => 'Language';

  @override
  String get clearHistory => 'Clear History';

  @override
  String get feedback => 'Feedback';

  @override
  String get checkForNewVersion => 'Check for New Version';

  @override
  String get mode => 'Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get logout => 'Logout';

  @override
  String get notificationsEnabled => 'Notifications enabled';

  @override
  String get notificationsDisabled => 'Notifications disabled';

  @override
  String languageChanged(Object language) {
    return 'Language changed to $language';
  }

  @override
  String get historyCleared => 'History cleared';

  @override
  String get feedbackSent => 'Feedback sent';

  @override
  String get appUpToDate => 'App is up to date';

  @override
  String get darkModeEnabled => 'Dark mode enabled';

  @override
  String get darkModeDisabled => 'Dark mode disabled';

  @override
  String get feedbackRequired => 'Please provide your feedback';

  @override
  String get feedbackSubmitted => 'Thank you for your feedback!';

  @override
  String get rateApp => 'Rate our app';

  @override
  String get shareOpinion => 'Share your opinion';

  @override
  String get feedbackHint => 'Tell us what you think about the app...';

  @override
  String get appPerformance => 'How would you rate the app\'s performance?';

  @override
  String get excellent => 'Excellent';

  @override
  String get good => 'Good';

  @override
  String get average => 'Average';

  @override
  String get poor => 'Poor';

  @override
  String get veryPoor => 'Very Poor';

  @override
  String get submitFeedback => 'Submit Feedback';
}
