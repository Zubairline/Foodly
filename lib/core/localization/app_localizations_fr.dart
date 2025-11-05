// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get settings => 'Paramètres';

  @override
  String get accountSettings => 'Paramètres du compte';

  @override
  String get language => 'Langue';

  @override
  String get clearHistory => 'Effacer l\'historique';

  @override
  String get feedback => 'Commentaires';

  @override
  String get checkForNewVersion => 'Vérifier les nouvelles versions';

  @override
  String get mode => 'Mode';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get notificationsEnabled => 'Notifications activées';

  @override
  String get notificationsDisabled => 'Notifications désactivées';

  @override
  String languageChanged(Object language) {
    return 'Langue changée en $language';
  }

  @override
  String get historyCleared => 'Historique effacé';

  @override
  String get feedbackSent => 'Commentaires envoyés';

  @override
  String get appUpToDate => 'L\'app est à jour';

  @override
  String get darkModeEnabled => 'Mode sombre activé';

  @override
  String get darkModeDisabled => 'Mode sombre désactivé';

  @override
  String get feedbackRequired => 'Veuillez fournir vos commentaires';

  @override
  String get feedbackSubmitted => 'Merci pour vos commentaires !';

  @override
  String get rateApp => 'Évaluez notre app';

  @override
  String get shareOpinion => 'Partagez votre avis';

  @override
  String get feedbackHint => 'Dites-nous ce que vous pensez de l\'app...';

  @override
  String get appPerformance => 'Comment évalueriez-vous les performances de l\'app ?';

  @override
  String get excellent => 'Excellent';

  @override
  String get good => 'Bien';

  @override
  String get average => 'Moyen';

  @override
  String get poor => 'Médiocre';

  @override
  String get veryPoor => 'Très médiocre';

  @override
  String get submitFeedback => 'Envoyer les commentaires';
}
