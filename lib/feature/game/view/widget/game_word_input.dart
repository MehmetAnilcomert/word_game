part of '../game_view.dart';

class _GameWordInput extends StatefulWidget {
  final String roomId;
  final String playerName;

  const _GameWordInput({required this.roomId, required this.playerName});

  @override
  State<_GameWordInput> createState() => _GameWordInputState();
}

class _GameWordInputState extends State<_GameWordInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        onSubmitted: (word) {
          if (word.trim().isNotEmpty) {
            context
                .read<GameBloc>()
                .add(SubmitWord(widget.roomId, widget.playerName, word));
            _controller.clear();
          }
        },
        decoration: InputDecoration(
          hintText: LocaleKeys.enterWord.tr(),
          border: InputBorder.none,
          icon: Icon(Icons.edit, color: context.colorScheme.primary),
        ),
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
