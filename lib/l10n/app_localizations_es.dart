// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get settings => 'Configuración';

  @override
  String get accountSettings => 'Configuración de cuenta';

  @override
  String get language => 'Idioma';

  @override
  String get clearHistory => 'Borrar historial';

  @override
  String get feedback => 'Comentarios';

  @override
  String get checkForNewVersion => 'Buscar nueva versión';

  @override
  String get mode => 'Modo';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get notificationsEnabled => 'Notificaciones activadas';

  @override
  String get notificationsDisabled => 'Notificaciones desactivadas';

  @override
  String languageChanged(Object language) {
    return 'Idioma cambiado a $language';
  }

  @override
  String get historyCleared => 'Historial borrado';

  @override
  String get feedbackSent => 'Comentarios enviados';

  @override
  String get appUpToDate => 'La app está actualizada';

  @override
  String get darkModeEnabled => 'Modo oscuro activado';

  @override
  String get darkModeDisabled => 'Modo oscuro desactivado';

  @override
  String get feedbackRequired => 'Por favor proporcione sus comentarios';

  @override
  String get feedbackSubmitted => '¡Gracias por sus comentarios!';

  @override
  String get rateApp => 'Califica nuestra app';

  @override
  String get shareOpinion => 'Comparte tu opinión';

  @override
  String get feedbackHint => 'Cuéntanos qué piensas de la app...';

  @override
  String get appPerformance => '¿Cómo calificarías el rendimiento de la app?';

  @override
  String get excellent => 'Excelente';

  @override
  String get good => 'Bueno';

  @override
  String get average => 'Promedio';

  @override
  String get poor => 'Deficiente';

  @override
  String get veryPoor => 'Muy deficiente';

  @override
  String get submitFeedback => 'Enviar comentarios';
}
