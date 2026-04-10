import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:word_game/feature/wordle/view/wordle_view.dart';
import 'package:word_game/product/init/language/locale_keys.g.dart';
import 'package:word_game/product/init/product_localization.dart';
import 'package:word_game/product/init/theme/app_theme_extension.dart';

part 'widget/wordle_create_dropdowns.dart';

/// Screen for starting a new Wordle game with custom settings.
class WordleCreateView extends StatefulWidget {
  /// Initializes a [WordleCreateView].
  const WordleCreateView({super.key});

  @override
  State<WordleCreateView> createState() => _WordleCreateViewState();
}

class _WordleCreateViewState extends State<WordleCreateView> {
  String? _initialLangChecked;
  late final ValueNotifier<String> _selectedLangNotifier;
  final ValueNotifier<int> _selectedLengthNotifier = ValueNotifier<int>(5);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialLangChecked == null) {
      var lang = ProductLocalization.getCurrentLanguageCode(context);
      // fallback or basic lang support
      if (lang != 'tr' && lang != 'en') {
        lang = 'en';
      }
      _initialLangChecked = lang;
      _selectedLangNotifier = ValueNotifier<String>(lang);
    }
  }

  @override
  void dispose() {
    _selectedLangNotifier.dispose();
    _selectedLengthNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: context.backgroundGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(LocaleKeys.wordleButton.tr()),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ValueListenableBuilder<String>(
                                valueListenable: _selectedLangNotifier,
                                builder: (context, lang, child) {
                                  return _LanguageDropdown(
                                    selectedLang: lang,
                                    onChanged: (val) {
                                      if (val != null) {
                                        _selectedLangNotifier.value = val;
                                      }
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              ValueListenableBuilder<int>(
                                valueListenable: _selectedLengthNotifier,
                                builder: (context, length, child) {
                                  return _LengthDropdown(
                                    selectedLength: length,
                                    onChanged: (val) {
                                      if (val != null) {
                                        _selectedLengthNotifier.value = val;
                                      }
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 40),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (context) => WordleView(
                                        wordLength:
                                            _selectedLengthNotifier.value,
                                        lang: _selectedLangNotifier.value,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: context.colorScheme.primary,
                                  foregroundColor:
                                      context.colorScheme.onPrimary,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 32,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  minimumSize: const Size.fromHeight(50),
                                ),
                                child: Text(
                                  LocaleKeys.startGame.tr(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
