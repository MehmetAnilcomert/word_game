part of '../wordle_create_view.dart';

class _LanguageDropdown extends StatelessWidget {
  const _LanguageDropdown({
    required this.selectedLang,
    required this.onChanged,
  });

  final String selectedLang;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedLang,
      decoration: InputDecoration(
        labelText: LocaleKeys.language.tr(),
        prefixIcon: const Icon(Icons.language),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: context.colorScheme.surface,
      ),
      items: [
        DropdownMenuItem(value: 'en', child: Text(LocaleKeys.english.tr())),
        DropdownMenuItem(value: 'tr', child: Text(LocaleKeys.turkish.tr())),
      ],
      onChanged: onChanged,
    );
  }
}

class _LengthDropdown extends StatelessWidget {
  const _LengthDropdown({
    required this.selectedLength,
    required this.onChanged,
  });

  final int selectedLength;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      initialValue: selectedLength,
      decoration: InputDecoration(
        labelText: LocaleKeys.enterLetterNumber.tr(),
        prefixIcon: const Icon(Icons.format_size),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: context.colorScheme.surface,
      ),
      items: const [
        DropdownMenuItem(value: 4, child: Text('4')),
        DropdownMenuItem(value: 5, child: Text('5')),
        DropdownMenuItem(value: 6, child: Text('6')),
      ],
      onChanged: onChanged,
    );
  }
}
