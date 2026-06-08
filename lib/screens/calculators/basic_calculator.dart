import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_calculator/l10n/generated/l10n.dart';

class BasicCalculator extends ConsumerStatefulWidget {
  const BasicCalculator({super.key});

  @override
  ConsumerState<BasicCalculator> createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends ConsumerState<BasicCalculator> {
  String _input = '0';
  String _result = '';
  String _operator = '';
  double _num = 0;
  bool _isOperationPressed = false;
  String _history = '';
  String _currentCalculation = '';
  bool _isResultShown = false;

  void _onNumberPressed(String number) {
    setState(() {
      if (_input == '0' || _isOperationPressed || _isResultShown) {
        _input = number;
        _isOperationPressed = false;

        if (_isResultShown) {
          _result = '';
          _currentCalculation = '';
          _operator = '';
          _num = 0;
        }

        _isResultShown = false;
      } else {
        _input += number;
      }

      if (_operator.isNotEmpty) {
        _currentCalculation = '${_num.toString()} $_operator $_input';
      }
    });
  }

  void _onOperationPressed(String operation) {
    setState(() {
      if (_isResultShown) {
        _isResultShown = false;
        _result = '';
        _currentCalculation = '';
      }

      _num = double.parse(_input);
      _operator = operation;
      _isOperationPressed = true;

      _currentCalculation = '${_num.toString()} $operation';
    });
  }

  void _onEqualsPressed() {
    setState(() {
      double num2 = double.parse(_input);
      double result = 0;
      String fullCalculation = '$_num $_operator $num2';

      switch (_operator) {
        case '+':
          result = _num + num2;
          break;
        case '-':
          result = _num - num2;
          break;
        case '*':
          result = _num * num2;
          break;
        case '/':
          if (num2 != 0) {
            result = _num / num2;
          } else {
            _result = 'Error';
            _input = '0';
            _history = '$fullCalculation = Error';
            _currentCalculation = '';
            _isResultShown = true;
            return;
          }
          break;
      }

      _result = (result == result.toInt())
          ? result.toInt().toString()
          : result.toString();

      _history = '$fullCalculation = $_result';
      _input = '0';
      _currentCalculation = '';
      _operator = '';
      _isResultShown = true;
    });
  }

  void _onClearPressed() {
    setState(() {
      _input = '0';
      _result = '';
      _operator = '';
      _num = 0;
      _currentCalculation = '';
      _isResultShown = false;
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

  Widget _buildButton({
    required String text,
    required Color textColor,
    required Color buttonColor,
    required VoidCallback onPressed,
  }) {
    bool isWideButton = text == '0';

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
            padding: const EdgeInsets.all(20),
            elevation: 4,
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final displayColor = theme.colorScheme.surfaceContainer;
    final operatorButtonColor = theme.colorScheme.primaryContainer;
    final numberButtonColor = theme.colorScheme.secondaryContainer;
    final functionButtonColor = theme.colorScheme.tertiaryContainer;
    final numberTextColor = theme.colorScheme.onSecondaryContainer;
    final operatorTextColor = theme.colorScheme.onPrimaryContainer;
    final functionTextColor = theme.colorScheme.onTertiaryContainer;

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: displayColor,
                borderRadius: BorderRadius.circular(24),
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
                  if (_history.isNotEmpty)
                    Text(
                      _history,
                      style: TextStyle(
                        fontSize: 18,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.end,
                    ),

                  const SizedBox(height: 5),

                  if (_currentCalculation.isNotEmpty)
                    Text(
                      _currentCalculation,
                      style: TextStyle(
                        fontSize: 24,
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.end,
                    ),

                  const SizedBox(height: 10),

                  if (_result.isNotEmpty)
                    Text(
                      '= $_result',
                      style: TextStyle(
                        fontSize: 36,
                        color: operatorTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.end,
                    ),

                  Text(
                    _input,
                    style: TextStyle(
                      fontSize: 52,
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
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
                          text: 'x',
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
                          text: '0',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: () => _onNumberPressed('0'),
                        ),

                        _buildButton(
                          text: '.',
                          textColor: numberTextColor,
                          buttonColor: numberButtonColor,
                          onPressed: _onDecimalPressed,
                        ),

                        _buildButton(
                          text: '=',
                          textColor: operatorTextColor,
                          buttonColor: operatorButtonColor,
                          onPressed: _onEqualsPressed,
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
