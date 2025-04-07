import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/rates_page_cubit.dart';

class RatesPage extends StatefulWidget {
  const RatesPage({super.key});

  @override
  State<RatesPage> createState() => _RatesPageState();
}

class _RatesPageState extends State<RatesPage> {
  @override
  void initState() {
    super.initState();
    context.read<RatesPageCubit>().fetchRates();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatesPageCubit, RatesPageState>(
      builder: (context, state) {
        if (state is RatesPageLoading || state is RatesPageInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RatesPageLoaded) {
          return ListView.separated(
            itemCount: state.rates.length,
            itemBuilder: (context, index) {
              final item = state.rates[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Text(
                    item.currencySymbol ?? '?',
                    textAlign: TextAlign.center,
                  ),
                ),
                title: Text(item.symbol),
                trailing: Text(
                  '\$${item.rateUsd}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              );
            },
            separatorBuilder:
                (context, index) => const Divider(height: 1, indent: 70),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
