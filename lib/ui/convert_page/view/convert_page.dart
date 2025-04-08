import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/currency.dart';
import '../../rates_page/cubit/rates_cubit.dart';
import '../cubit/convert_page_cubit.dart';
import 'show_currency_picker.dart';

class ConvertPage extends StatefulWidget {
  const ConvertPage({super.key});

  @override
  State<ConvertPage> createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {
  final TextEditingController _amountController = TextEditingController();
  List<Currency> _availableCurrencies = [];

  @override
  void initState() {
    super.initState();
    _amountController.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<RatesCubit, RatesState>(
      builder: (context, state) {
        if (state is RatesLoading || state is RatesInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RatesLoaded) {
          _availableCurrencies = state.rates;

          return BlocProvider(
            create: (context) => ConvertPageCubit()..init(_availableCurrencies),
            child: BlocBuilder<ConvertPageCubit, ConvertPageState>(
              builder: (context, state) {
                return switch (state) {
                  ConvertPageInitial() => const SizedBox.shrink(),
                  ConvertPageLoaded() => SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From', style: theme.textTheme.titleMedium),
                        const SizedBox(height: 8.0),
                        InkWell(
                          onTap:
                              () => showCurrencyPicker(
                                context: context,
                                fieldType: 'from',
                                currencies: _availableCurrencies,
                                initialCurrency: state.fromCurrency.symbol,
                                restrictedCurrency: state.toCurrency,
                                onCurrencySelected: (Currency fromCurrency) {
                                  context.read<ConvertPageCubit>().updateAmount(
                                    amount: state.amount,
                                    fromCurrency: fromCurrency,
                                    toCurrency: state.toCurrency,
                                  );
                                },
                              ),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 8.0,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  state.fromCurrency.symbol,
                                  style: theme.textTheme.bodyLarge,
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text('To', style: theme.textTheme.titleMedium),
                        const SizedBox(height: 8.0),
                        InkWell(
                          onTap:
                              () => showCurrencyPicker(
                                context: context,
                                fieldType: 'to',
                                currencies: _availableCurrencies,
                                initialCurrency: state.toCurrency.symbol,
                                restrictedCurrency: state.fromCurrency,
                                onCurrencySelected: (Currency toCurrency) {
                                  context.read<ConvertPageCubit>().updateAmount(
                                    amount: state.amount,
                                    fromCurrency: state.fromCurrency,
                                    toCurrency: toCurrency,
                                  );
                                },
                              ),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 8.0,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  state.toCurrency.symbol,
                                  style: theme.textTheme.bodyLarge,
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text('Amount', style: theme.textTheme.titleMedium),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),

                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*'),
                            ),
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 8.0,
                            ),
                          ),
                          onChanged: (value) {
                            context.read<ConvertPageCubit>().updateAmount(
                              amount: value,
                              fromCurrency: state.fromCurrency,
                              toCurrency: state.toCurrency,
                            );
                          },
                        ),
                        const SizedBox(height: 24.0),
                        Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 24.0,
                              horizontal: 16.0,
                            ),
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '1 ${state.fromCurrency.symbol}',
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Icon(
                                    Icons.swap_vert,
                                    size: 24.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  '${state.resultWithCommission} ${state.toCurrency.symbol}',
                                  style: theme.textTheme.headlineMedium
                                      ?.copyWith(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  '(${state.result} ${state.toCurrency.symbol} + 3%)',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                };
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
