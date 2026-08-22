import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
    Locale('pt', 'BR'),
  ];

  /// Application name
  ///
  /// In en, this message translates to:
  /// **'ClipBear'**
  String get appName;

  /// Application tagline
  ///
  /// In en, this message translates to:
  /// **'Your Digital Companion'**
  String get appTagline;

  /// No description provided for @common_ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get common_ok;

  /// No description provided for @common_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// No description provided for @common_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get common_save;

  /// No description provided for @common_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get common_delete;

  /// No description provided for @common_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get common_edit;

  /// No description provided for @common_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get common_close;

  /// No description provided for @common_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get common_back;

  /// No description provided for @common_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get common_next;

  /// No description provided for @common_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get common_skip;

  /// No description provided for @common_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get common_done;

  /// No description provided for @common_yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get common_yes;

  /// No description provided for @common_no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get common_no;

  /// No description provided for @common_accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get common_accept;

  /// No description provided for @common_reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get common_reject;

  /// No description provided for @common_loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get common_loading;

  /// No description provided for @common_error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get common_error;

  /// No description provided for @common_success.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get common_success;

  /// No description provided for @greeting_morning.
  ///
  /// In en, this message translates to:
  /// **'Good morning! 👋'**
  String get greeting_morning;

  /// No description provided for @greeting_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon! 👋'**
  String get greeting_afternoon;

  /// No description provided for @greeting_evening.
  ///
  /// In en, this message translates to:
  /// **'Good evening! 👋'**
  String get greeting_evening;

  /// No description provided for @greeting_night.
  ///
  /// In en, this message translates to:
  /// **'Hello! 👋'**
  String get greeting_night;

  /// No description provided for @home_title.
  ///
  /// In en, this message translates to:
  /// **'🐻 ClipBear'**
  String get home_title;

  /// No description provided for @home_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to ClipBear!'**
  String get home_welcome;

  /// No description provided for @home_welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Your digital companion reimagined with Flutter'**
  String get home_welcomeMessage;

  /// No description provided for @home_yourActivityToday.
  ///
  /// In en, this message translates to:
  /// **'Your Activity Today'**
  String get home_yourActivityToday;

  /// No description provided for @home_noSuggestionsYet.
  ///
  /// In en, this message translates to:
  /// **'0 suggestions received'**
  String get home_noSuggestionsYet;

  /// No description provided for @home_statsAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get home_statsAccepted;

  /// No description provided for @home_statsRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get home_statsRejected;

  /// No description provided for @home_statsPostponed.
  ///
  /// In en, this message translates to:
  /// **'Postponed'**
  String get home_statsPostponed;

  /// No description provided for @home_launchMessage.
  ///
  /// In en, this message translates to:
  /// **'🎉 Flutter Project Launched!'**
  String get home_launchMessage;

  /// No description provided for @home_launchDescription.
  ///
  /// In en, this message translates to:
  /// **'ClipBear has been modernized with Flutter! Now with Material Design 3, fluid animations, and cross-platform support.'**
  String get home_launchDescription;

  /// No description provided for @home_buttonStartTour.
  ///
  /// In en, this message translates to:
  /// **'Start Tour'**
  String get home_buttonStartTour;

  /// No description provided for @home_buttonAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get home_buttonAbout;

  /// No description provided for @onboarding_welcome_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to ClipBear! 🐻'**
  String get onboarding_welcome_title;

  /// No description provided for @onboarding_welcome_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your smart and adorable digital companion'**
  String get onboarding_welcome_subtitle;

  /// No description provided for @onboarding_welcome_description.
  ///
  /// In en, this message translates to:
  /// **'ClipBear observes your habits and offers helpful suggestions to improve your experience, always respecting your privacy.'**
  String get onboarding_welcome_description;

  /// No description provided for @onboarding_privacy_title.
  ///
  /// In en, this message translates to:
  /// **'Privacy First 🔒'**
  String get onboarding_privacy_title;

  /// No description provided for @onboarding_privacy_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your data is yours'**
  String get onboarding_privacy_subtitle;

  /// No description provided for @onboarding_privacy_description.
  ///
  /// In en, this message translates to:
  /// **'All your data stays on your device. We never send anything to our servers. You have full control.'**
  String get onboarding_privacy_description;

  /// No description provided for @onboarding_privacy_point1.
  ///
  /// In en, this message translates to:
  /// **'✅ Data stays local'**
  String get onboarding_privacy_point1;

  /// No description provided for @onboarding_privacy_point2.
  ///
  /// In en, this message translates to:
  /// **'✅ No third-party tracking'**
  String get onboarding_privacy_point2;

  /// No description provided for @onboarding_privacy_point3.
  ///
  /// In en, this message translates to:
  /// **'✅ Export and delete anytime'**
  String get onboarding_privacy_point3;

  /// No description provided for @onboarding_privacy_point4.
  ///
  /// In en, this message translates to:
  /// **'✅ Open source auditable code'**
  String get onboarding_privacy_point4;

  /// No description provided for @onboarding_features_title.
  ///
  /// In en, this message translates to:
  /// **'Meet Tinker 🤖'**
  String get onboarding_features_title;

  /// No description provided for @onboarding_features_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your animated robot friend'**
  String get onboarding_features_subtitle;

  /// No description provided for @onboarding_features_description.
  ///
  /// In en, this message translates to:
  /// **'Tinker is expressive, fun, and here to help. He learns from you and makes suggestions at the right time.'**
  String get onboarding_features_description;

  /// No description provided for @onboarding_features_point1.
  ///
  /// In en, this message translates to:
  /// **'💡 Smart suggestions'**
  String get onboarding_features_point1;

  /// No description provided for @onboarding_features_point2.
  ///
  /// In en, this message translates to:
  /// **'🎭 Multiple expressions'**
  String get onboarding_features_point2;

  /// No description provided for @onboarding_features_point3.
  ///
  /// In en, this message translates to:
  /// **'🏆 Achievement system'**
  String get onboarding_features_point3;

  /// No description provided for @onboarding_features_point4.
  ///
  /// In en, this message translates to:
  /// **'📊 Insights about your habits'**
  String get onboarding_features_point4;

  /// No description provided for @onboarding_permissions_title.
  ///
  /// In en, this message translates to:
  /// **'Required Permissions 🔔'**
  String get onboarding_permissions_title;

  /// No description provided for @onboarding_permissions_subtitle.
  ///
  /// In en, this message translates to:
  /// **'To work better'**
  String get onboarding_permissions_subtitle;

  /// No description provided for @onboarding_permissions_description.
  ///
  /// In en, this message translates to:
  /// **'ClipBear needs some permissions to offer the best experience. You can skip this step and grant them later.'**
  String get onboarding_permissions_description;

  /// No description provided for @onboarding_permissions_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get onboarding_permissions_notifications;

  /// No description provided for @onboarding_permissions_notifications_desc.
  ///
  /// In en, this message translates to:
  /// **'To send helpful suggestions'**
  String get onboarding_permissions_notifications_desc;

  /// No description provided for @onboarding_permissions_usage.
  ///
  /// In en, this message translates to:
  /// **'App Usage'**
  String get onboarding_permissions_usage;

  /// No description provided for @onboarding_permissions_usage_desc.
  ///
  /// In en, this message translates to:
  /// **'To understand your habits'**
  String get onboarding_permissions_usage_desc;

  /// No description provided for @onboarding_permissions_enable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get onboarding_permissions_enable;

  /// No description provided for @onboarding_permissions_later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get onboarding_permissions_later;

  /// No description provided for @onboarding_getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboarding_getStarted;

  /// No description provided for @onboarding_skipAll.
  ///
  /// In en, this message translates to:
  /// **'Skip All'**
  String get onboarding_skipAll;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settings_appearance;

  /// No description provided for @settings_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme;

  /// No description provided for @settings_theme_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settings_theme_light;

  /// No description provided for @settings_theme_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settings_theme_dark;

  /// No description provided for @settings_theme_auto.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get settings_theme_auto;

  /// No description provided for @settings_accentColor.
  ///
  /// In en, this message translates to:
  /// **'Accent Color'**
  String get settings_accentColor;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @settings_language_pt.
  ///
  /// In en, this message translates to:
  /// **'Português'**
  String get settings_language_pt;

  /// No description provided for @settings_language_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settings_language_en;

  /// No description provided for @settings_avatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get settings_avatar;

  /// No description provided for @settings_avatar_style.
  ///
  /// In en, this message translates to:
  /// **'Avatar Style'**
  String get settings_avatar_style;

  /// No description provided for @settings_avatar_customize.
  ///
  /// In en, this message translates to:
  /// **'Customize Avatar'**
  String get settings_avatar_customize;

  /// No description provided for @settings_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settings_notifications;

  /// No description provided for @settings_notifications_enabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications Enabled'**
  String get settings_notifications_enabled;

  /// No description provided for @settings_notifications_intensity.
  ///
  /// In en, this message translates to:
  /// **'Intensity'**
  String get settings_notifications_intensity;

  /// No description provided for @settings_notifications_intensity_basic.
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get settings_notifications_intensity_basic;

  /// No description provided for @settings_notifications_intensity_proactive.
  ///
  /// In en, this message translates to:
  /// **'Proactive'**
  String get settings_notifications_intensity_proactive;

  /// No description provided for @settings_notifications_quietHours.
  ///
  /// In en, this message translates to:
  /// **'Quiet Hours'**
  String get settings_notifications_quietHours;

  /// No description provided for @settings_notifications_quietHours_start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get settings_notifications_quietHours_start;

  /// No description provided for @settings_notifications_quietHours_end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get settings_notifications_quietHours_end;

  /// No description provided for @settings_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Data'**
  String get settings_privacy;

  /// No description provided for @settings_privacy_dataExport.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get settings_privacy_dataExport;

  /// No description provided for @settings_privacy_dataDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete All Data'**
  String get settings_privacy_dataDelete;

  /// No description provided for @settings_privacy_deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all data? This action cannot be undone.'**
  String get settings_privacy_deleteConfirm;

  /// No description provided for @settings_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settings_privacy_policy;

  /// No description provided for @settings_privacy_terms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get settings_privacy_terms;

  /// No description provided for @settings_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settings_about;

  /// No description provided for @settings_about_version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settings_about_version;

  /// No description provided for @settings_about_credits.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get settings_about_credits;

  /// No description provided for @settings_about_openSource.
  ///
  /// In en, this message translates to:
  /// **'Open Source'**
  String get settings_about_openSource;

  /// No description provided for @suggestions_title.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get suggestions_title;

  /// No description provided for @suggestions_latest.
  ///
  /// In en, this message translates to:
  /// **'Latest Suggestion'**
  String get suggestions_latest;

  /// No description provided for @suggestions_noSuggestions.
  ///
  /// In en, this message translates to:
  /// **'No suggestions yet'**
  String get suggestions_noSuggestions;

  /// No description provided for @suggestions_whyThis.
  ///
  /// In en, this message translates to:
  /// **'Why?'**
  String get suggestions_whyThis;

  /// No description provided for @suggestions_timeAgo.
  ///
  /// In en, this message translates to:
  /// **'{time} ago'**
  String suggestions_timeAgo(String time);

  /// No description provided for @suggestions_accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get suggestions_accept;

  /// No description provided for @suggestions_reject.
  ///
  /// In en, this message translates to:
  /// **'No, thanks'**
  String get suggestions_reject;

  /// No description provided for @suggestions_postpone.
  ///
  /// In en, this message translates to:
  /// **'Remind me later'**
  String get suggestions_postpone;

  /// No description provided for @suggestions_postpone_30min.
  ///
  /// In en, this message translates to:
  /// **'In 30 minutes'**
  String get suggestions_postpone_30min;

  /// No description provided for @suggestions_postpone_1hour.
  ///
  /// In en, this message translates to:
  /// **'In 1 hour'**
  String get suggestions_postpone_1hour;

  /// No description provided for @suggestions_postpone_3hours.
  ///
  /// In en, this message translates to:
  /// **'In 3 hours'**
  String get suggestions_postpone_3hours;

  /// No description provided for @history_title.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history_title;

  /// No description provided for @history_insights.
  ///
  /// In en, this message translates to:
  /// **'Your Insights'**
  String get history_insights;

  /// No description provided for @history_thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get history_thisWeek;

  /// No description provided for @history_thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get history_thisMonth;

  /// No description provided for @history_allTime.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get history_allTime;

  /// No description provided for @history_suggestionsReceived.
  ///
  /// In en, this message translates to:
  /// **'Suggestions Received'**
  String get history_suggestionsReceived;

  /// No description provided for @history_acceptanceRate.
  ///
  /// In en, this message translates to:
  /// **'Acceptance Rate'**
  String get history_acceptanceRate;

  /// No description provided for @history_timeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get history_timeline;

  /// No description provided for @history_achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get history_achievements;

  /// No description provided for @achievements_title.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements_title;

  /// No description provided for @achievements_firstWeek.
  ///
  /// In en, this message translates to:
  /// **'First Week Complete'**
  String get achievements_firstWeek;

  /// No description provided for @achievements_firstWeek_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete your first week using ClipBear'**
  String get achievements_firstWeek_desc;

  /// No description provided for @achievements_tenAccepted.
  ///
  /// In en, this message translates to:
  /// **'10 Suggestions Accepted'**
  String get achievements_tenAccepted;

  /// No description provided for @achievements_tenAccepted_desc.
  ///
  /// In en, this message translates to:
  /// **'Accept 10 suggestions from Tinker'**
  String get achievements_tenAccepted_desc;

  /// No description provided for @achievements_fiftyAccepted.
  ///
  /// In en, this message translates to:
  /// **'50 Suggestions Accepted'**
  String get achievements_fiftyAccepted;

  /// No description provided for @achievements_fiftyAccepted_desc.
  ///
  /// In en, this message translates to:
  /// **'Accept 50 suggestions from Tinker'**
  String get achievements_fiftyAccepted_desc;

  /// No description provided for @achievements_perfectWeek.
  ///
  /// In en, this message translates to:
  /// **'Perfect Week'**
  String get achievements_perfectWeek;

  /// No description provided for @achievements_perfectWeek_desc.
  ///
  /// In en, this message translates to:
  /// **'Use ClipBear every day for a week'**
  String get achievements_perfectWeek_desc;

  /// No description provided for @notifications_newSuggestion_title.
  ///
  /// In en, this message translates to:
  /// **'New Suggestion from Tinker 💡'**
  String get notifications_newSuggestion_title;

  /// No description provided for @notifications_newSuggestion_body.
  ///
  /// In en, this message translates to:
  /// **'I have a suggestion for you!'**
  String get notifications_newSuggestion_body;

  /// No description provided for @notifications_achievement_title.
  ///
  /// In en, this message translates to:
  /// **'Achievement Unlocked! 🎉'**
  String get notifications_achievement_title;

  /// No description provided for @notifications_achievement_body.
  ///
  /// In en, this message translates to:
  /// **'You unlocked: {achievement}'**
  String notifications_achievement_body(String achievement);

  /// No description provided for @errors_generic.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errors_generic;

  /// No description provided for @errors_network.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get errors_network;

  /// No description provided for @errors_permission_denied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied'**
  String get errors_permission_denied;

  /// No description provided for @errors_dataExport_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to export data'**
  String get errors_dataExport_failed;

  /// No description provided for @errors_dataDelete_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete data'**
  String get errors_dataDelete_failed;

  /// No description provided for @success_dataSaved.
  ///
  /// In en, this message translates to:
  /// **'Data saved successfully'**
  String get success_dataSaved;

  /// No description provided for @success_dataExported.
  ///
  /// In en, this message translates to:
  /// **'Data exported successfully'**
  String get success_dataExported;

  /// No description provided for @success_dataDeleted.
  ///
  /// In en, this message translates to:
  /// **'Data deleted successfully'**
  String get success_dataDeleted;

  /// No description provided for @success_settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved'**
  String get success_settingsSaved;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
