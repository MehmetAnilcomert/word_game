part of '../wordle_view.dart';

class _WordleSettingsDialog extends StatefulWidget {
  const _WordleSettingsDialog();
  @override
  State<_WordleSettingsDialog> createState() => _WordleSettingsDialogState();
}

class _WordleSettingsDialogState extends State<_WordleSettingsDialog> {
  late String _tempLang;
  late int _tempLength;

  @override
  void initState() {
    super.initState();
    final state = context.read<WordleViewModel>().state;
    _tempLang = state.lang;
    _tempLength = state.wordLength;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(LocaleKeys.settingsTitle.tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLanguageSelector(),
          const SizedBox(height: 20),
          _buildLengthSelector(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(LocaleKeys.cancel.tr()),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<WordleViewModel>().updateSettings(
                  lang: _tempLang,
                  wordLength: _tempLength,
                );
            Navigator.of(context).pop();
          },
          child: Text(LocaleKeys.applyRestart.tr()),
        ),
      ],
    );
  }

  Widget _buildLanguageSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(LocaleKeys.language.tr()),
        DropdownButton<String>(
          value: _tempLang,
          items: [
            DropdownMenuItem(value: 'en', child: Text(LocaleKeys.english.tr())),
            DropdownMenuItem(value: 'tr', child: Text(LocaleKeys.turkish.tr())),
          ],
          onChanged: (val) {
            if (val != null) setState(() => _tempLang = val);
          },
        ),
      ],
    );
  }

  Widget _buildLengthSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(LocaleKeys.enterLetterNumber.tr()),
        DropdownButton<int>(
          value: _tempLength,
          items: const [
            DropdownMenuItem(value: 4, child: Text('4')),
            DropdownMenuItem(value: 5, child: Text('5')),
            DropdownMenuItem(value: 6, child: Text('6')),
          ],
          onChanged: (val) {
            if (val != null) setState(() => _tempLength = val);
          },
        ),
      ],
    );
  }
}
