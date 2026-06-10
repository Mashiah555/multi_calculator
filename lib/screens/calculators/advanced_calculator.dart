import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AdvancedCalculator extends ConsumerStatefulWidget {
  const AdvancedCalculator({super.key});

  @override
  ConsumerState<AdvancedCalculator> createState() => _AdvancedCalculatorState();
}

class _AdvancedCalculatorState extends ConsumerState<AdvancedCalculator> {
  final formatter = NumberFormat.decimalPattern();
  String _input = '0';
  String _result = '';
  String _operator = '';
  double _num = 0;
  bool _isOperationPressed = false;
  String _history = '';
  String _displayedCalculation = '';
  bool _isResultState = false;

  void _onNumberPressed(String number) {
    setState(() {
      if (_input == '0' || _isOperationPressed || _isResultState) {
        _input = number;
        _displayedCalculation = number;
        _result = number;
        _isOperationPressed = false;

        if (_isResultState) {
          _operator = '';
          _num = 0;
        }

        _isResultState = false;
      } else {
        _input += number;
      }

      if (_operator.isNotEmpty) {
        _displayedCalculation = '${formatter.format(_num)} $_operator $_input';
        _result =
            _calculateResult(num2: double.parse(_input))?.toString() ?? 'Error';
      }
    });
  }

  void _onOperationPressed(String operation) {
    setState(() {
      if (_isResultState) {
        _isResultState = false;
        _displayedCalculation = _result;
        _input = _result;
      }

      _num = double.parse(_input);
      _operator = operation;
      _isOperationPressed = true;

      _displayedCalculation = '${formatter.format(_num)} $operation';
    });
  }

  void _onExpressionPressed() {
    // TODO: Implement expressions calculation
  }

  void _onEqualsPressed() {
    setState(() {
      double num2 = double.parse(_input);
      String fullCalculation = '$_num $_operator $num2';
      final result = _calculateResult(num2: num2);

      if (result == null) {
        _result = 'Error';
        _input = '0';
        _displayedCalculation = '0';
        _history = '$fullCalculation = Error';
        _isResultState = true;
        return;
      }

      _result = (result == result.toInt())
          ? result.toInt().toString()
          : result.toString();

      _history = '$fullCalculation = $_result';
      _input = '0';
      _displayedCalculation = '';
      _operator = '';
      _isResultState = true;
    });
  }

  void _onClearPressed() {
    setState(() {
      _input = '0';
      _displayedCalculation = '0';
      _result = '';
      _operator = '';
      _num = 0;
      _isResultState = false;
    });
  }

  void _onBackspacePressed() {
    setState(() {
      if (_input.length > 1) {
        _input = _input.substring(0, _input.length - 1);
      } else {
        _input = '0';
      }
    });
  }

  void _onDecimalPressed() {
    setState(() {
      if (!_input.contains('.')) {
        _input += '.';
      }
    });
  }

  double? _calculateResult({required double num2}) {
    switch (_operator) {
      case '+':
        return _num + num2;
      case '-':
        return _num - num2;
      case 'x':
        return _num * num2;
      case '/':
        if (num2 != 0) {
          return _num / num2;
        } else {
          return null;
        }
      default:
        return null;
    }
  }

  Widget _buildButton({
    required String text,
    required Color textColor,
    required Color buttonColor,
    required VoidCallback onPressed,
    bool isWideButton = false,
  }) {
    final isLong = text.length >= 3;
    return Expanded(
      flex: isWideButton ? 2 : 1,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(12),
            elevation: 4,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isLong ? 20 : 24,
              fontWeight: isLong ? FontWeight.w300 : FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final displayColor = theme.colorScheme.surfaceContainer;
    final operatorButtonColor = theme.colorScheme.primaryContainer;
    final operatorTextColor = theme.colorScheme.onPrimaryContainer;
    final numberButtonColor = theme.colorScheme.secondaryContainer;
    final numberTextColor = theme.colorScheme.onSecondaryContainer;
    final functionButtonColor = theme.colorScheme.tertiaryContainer;
    final functionTextColor = theme.colorScheme.onTertiaryContainer;

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 8,

            // Display Container
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: displayColor,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: displayColor.withAlpha(25),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // History Text
                  if (_history.isNotEmpty)
                    Text(
                      _history,
                      style: TextStyle(
                        fontSize: 20,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.end,
                    ),

                  const SizedBox(height: 10),

                  // Current Calculation Text
                  if (_displayedCalculation.isNotEmpty)
                    Text(
                      _displayedCalculation,
                      style: TextStyle(
                        fontSize: 46,
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),

                  const SizedBox(height: 5),

                  // Result Text
                  if (_result.isNotEmpty)
                    Text(
                      '= $_result',
                      style: TextStyle(
                        fontSize: _isResultState ? 50 : 28,
                        color: operatorTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.end,
                    ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 13,
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton(
                          text: 'x!',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: _onExpressionPressed,
                        ),

                        _buildButton(
                          text: 'AC',
                          textColor: functionTextColor,
                          buttonColor: functionButtonColor,
                          onPressed: _onClearPressed,
                        ),

                        _buildButton(
                          text: 'C',
                          textColor: functionTextColor,
                          buttonColor: functionButtonColor,
                          onPressed: _onBackspacePressed,
                        ),

                        _buildButton(
                          text: '%',
                          textColor: functionTextColor,
                          buttonColor: functionButtonColor,
                          onPressed: () {
                            setState(() {
                              double percentage = double.parse(_input) / 100;
                              _input = percentage.toString();
                            });
                          },
                        ),

                        _buildButton(
                          text: '/',
                          textColor: functionTextColor,
                          buttonColor: functionButtonColor,
                          onPressed: () => _onOperationPressed('/'),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        _buildButton(
                          text: 'x²',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: _onExpressionPressed,
                        ),

                        _buildButton(
                          text: '7',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: () => _onNumberPressed('7'),
                        ),

                        _buildButton(
                          text: '8',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: () => _onNumberPressed('8'),
                        ),

                        _buildButton(
                          text: '9',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: () => _onNumberPressed('9'),
                        ),

                        _buildButton(
                          text: 'X',
                          textColor: functionTextColor,
                          buttonColor: functionButtonColor,
                          onPressed: () => _onOperationPressed('x'),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        _buildButton(
                          text: '√x',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: _onExpressionPressed,
                        ),

                        _buildButton(
                          text: '4',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: () => _onNumberPressed('4'),
                        ),

                        _buildButton(
                          text: '5',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: () => _onNumberPressed('5'),
                        ),

                        _buildButton(
                          text: '6',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: () => _onNumberPressed('6'),
                        ),

                        _buildButton(
                          text: '-',
                          textColor: functionTextColor,
                          buttonColor: functionButtonColor,
                          onPressed: () => _onOperationPressed('-'),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        _buildButton(
                          text: 'π',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: _onExpressionPressed,
                        ),

                        _buildButton(
                          text: '1',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: () => _onNumberPressed('1'),
                        ),

                        _buildButton(
                          text: '2',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: () => _onNumberPressed('2'),
                        ),

                        _buildButton(
                          text: '3',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: () => _onNumberPressed('3'),
                        ),

                        _buildButton(
                          text: '+',
                          textColor: functionTextColor,
                          buttonColor: functionButtonColor,
                          onPressed: () => _onOperationPressed('+'),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        _buildButton(
                          text: 'e',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: _onExpressionPressed,
                        ),

                        _buildButton(
                          text: '.',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: _onDecimalPressed,
                        ),

                        _buildButton(
                          text: '0',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: () => _onNumberPressed('0'),
                        ),

                        _buildButton(
                          text: '=',
                          textColor: operatorTextColor,
                          buttonColor: operatorButtonColor,
                          onPressed: _onEqualsPressed,
                          isWideButton: true,
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        _buildButton(
                          text: 'lg',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: _onExpressionPressed,
                        ),

                        _buildButton(
                          text: 'ln',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: _onExpressionPressed,
                        ),

                        _buildButton(
                          text: 'si',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: _onExpressionPressed,
                        ),

                        _buildButton(
                          text: 'co',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: _onExpressionPressed,
                        ),

                        _buildButton(
                          text: 'tn',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: _onExpressionPressed,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
