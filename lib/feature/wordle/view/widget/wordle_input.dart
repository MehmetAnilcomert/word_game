part of '../wordle_view.dart';

class _WordleInput extends StatefulWidget {
  const _WordleInput({required this.wordLength, required this.onSubmitted});
  final int wordLength;
  final Function(String) onSubmitted;

  @override
  State<_WordleInput> createState() => _WordleInputState();
}

class _WordleInputState extends State<_WordleInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: context.colorScheme.surface.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            autofocus: true,
            maxLength: widget.wordLength,
            onChanged: (val) {
              context.read<WordleViewModel>().updateCurrentGuess(val);
            },
            onSubmitted: (val) {
              if (val.length == widget.wordLength) {
                widget.onSubmitted(val.toUpperCase());
                _controller.clear();
                _focusNode.requestFocus();
              }
            },
            decoration: InputDecoration(
              hintText: LocaleKeys.enterWord.tr(),
              counterText: '',
              border: InputBorder.none,
              icon: Icon(Icons.keyboard, color: context.colorScheme.primary),
            ),
            style: const TextStyle(fontSize: 18),
            textCapitalization: TextCapitalization.characters,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            if (_controller.text.length == widget.wordLength) {
              widget.onSubmitted(_controller.text.toUpperCase());
              _controller.clear();
              _focusNode.requestFocus();
            }
          },
          icon: const Icon(Icons.send),
          label: Text(LocaleKeys.confirm.tr()),
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.primary,
            foregroundColor: context.colorScheme.onPrimary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    );
  }
}
