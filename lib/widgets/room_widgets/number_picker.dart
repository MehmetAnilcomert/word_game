import 'package:flutter/material.dart';

class IntegerNumberSelector extends StatefulWidget {
  final String label;
  final IconData icon;
  final int minValue;
  final int maxValue;
  final void Function(int) onChanged;

  const IntegerNumberSelector({
    Key? key,
    required this.label,
    required this.icon,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _IntegerNumberSelectorState createState() => _IntegerNumberSelectorState();
}

class _IntegerNumberSelectorState extends State<IntegerNumberSelector> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.minValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade900),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(widget.icon, color: Colors.grey.shade600),
              SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: _currentValue > widget.minValue
                    ? () => _updateValue(_currentValue - 1)
                    : null,
              ),
              Expanded(
                child: Slider(
                  value: _currentValue.toDouble(),
                  min: widget.minValue.toDouble(),
                  max: widget.maxValue.toDouble(),
                  divisions: widget.maxValue - widget.minValue,
                  onChanged: (value) => _updateValue(value.round()),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _currentValue < widget.maxValue
                    ? () => _updateValue(_currentValue + 1)
                    : null,
              ),
              SizedBox(width: 16),
              Text(
                _currentValue.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _updateValue(int newValue) {
    setState(() {
      _currentValue = newValue;
    });
    widget.onChanged(newValue);
  }
}
