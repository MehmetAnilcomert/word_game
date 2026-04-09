part of '../home_view.dart';

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocaleKeys.appTitle.tr(),
            style: TextStyle(
              color: context.colorScheme.onPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const _LanguageToggle(),
        ],
      ),
    );
  }
}

class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
        onPressed: () {
          final currentLocale = context.locale;
          if (currentLocale.languageCode == Locales.en.locale.languageCode) {
            ProductLocalization.updateLang(context: context, locale: Locales.tr);
          } else {
            ProductLocalization.updateLang(context: context, locale: Locales.en);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CountryFlag.fromLanguageCode(
            context.locale.languageCode == 'en' ? 'EN' : 'TR',
            width: 50,
            height: 50,
            shape: const Circle(),
          ),
        ),
      ),
    );
  }
}
