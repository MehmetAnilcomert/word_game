part of '../room_view.dart';

class _IntegerNumberSelector extends StatelessWidget {
  final String label;
  final IconData icon;
  final int minValue;
  final int maxValue;
  final void Function(int) onChanged;

  const _IntegerNumberSelector({
    required this.label,
    required this.icon,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 10),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
        DropdownButton<int>(
          value: minValue,
          items: List.generate(
            maxValue - minValue + 1,
            (index) => DropdownMenuItem(
              value: minValue + index,
              child: Text('${minValue + index}'),
            ),
          ),
          onChanged: (val) {
            if (val != null) {
              onChanged(val);
            }
          },
        ),
      ],
    );
  }
}
