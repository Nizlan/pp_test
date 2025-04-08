import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/currency.dart';

void showCurrencyPicker({
  required BuildContext context,
  required String fieldType,
  required List<Currency> currencies,
  required String initialCurrency,
  required Function(Currency) onCurrencySelected,
  required Currency restrictedCurrency,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder:
        (BuildContext context) => _CurrencyPicker(
          currencies: currencies,
          initialCurrency: initialCurrency,
          restrictedCurrency: restrictedCurrency,
          onCurrencySelected: onCurrencySelected,
        ),
  );
}

class _CurrencyPicker extends StatefulWidget {
  final List<Currency> currencies;
  final String initialCurrency;
  final Currency restrictedCurrency;
  final Function(Currency) onCurrencySelected;

  const _CurrencyPicker({
    required this.currencies,
    required this.initialCurrency,
    required this.restrictedCurrency,
    required this.onCurrencySelected,
  });

  @override
  State<_CurrencyPicker> createState() => __CurrencyPickerState();
}

class __CurrencyPickerState extends State<_CurrencyPicker> {
  late int initialIndex;

  late final FixedExtentScrollController scrollController;

  static const double itemHeight = 40.0;

  late bool allowed;

  @override
  void initState() {
    initialIndex = widget.currencies.indexWhere(
      (c) => c.symbol == widget.initialCurrency,
    );
    if (initialIndex < 0) initialIndex = 0;

    scrollController = FixedExtentScrollController(initialItem: initialIndex);

    allowed =
        widget.currencies[initialIndex].symbol !=
        widget.restrictedCurrency.symbol;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  child: const Text('Cancel'),
                ),
                CupertinoButton(
                  onPressed:
                      allowed
                          ? () {
                            widget.onCurrencySelected(
                              widget.currencies[scrollController.selectedItem],
                            );
                            Navigator.pop(context);
                          }
                          : null,
                  padding: EdgeInsets.zero,
                  child: const Text(
                    'Confirm',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1, height: 1),
          Expanded(
            child: CupertinoPicker(
              itemExtent: itemHeight,
              scrollController: scrollController,
              useMagnifier: true,
              magnification: 1.01,
              children:
                  widget.currencies.map((currency) {
                    return Center(
                      child: Text(
                        currency.symbol,
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
              onSelectedItemChanged: (index) {
                final bool newAllowed =
                    widget.currencies[scrollController.selectedItem].symbol !=
                    widget.restrictedCurrency.symbol;

                if (newAllowed != allowed) {
                  allowed = newAllowed;
                  setState(() {});
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
