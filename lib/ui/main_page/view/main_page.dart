import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/auth_repo/auth_repo.dart';
import '../../../data/repositories/currencies_repo/currencies_repo.dart';
import '../../auth_page/view/auth_page.dart';
import '../../convert_page/view/convert_page.dart';
import '../../rates_page/cubit/rates_cubit.dart';
import '../../rates_page/view/rates_page.dart';
import '../cubit/main_page_cubit.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    RatesPage(),
    ConvertPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainPageCubit>(
          create: (context) => MainPageCubit(context.read<AuthRepo>()),
        ),
        BlocProvider<RatesCubit>(
          create:
              (context) =>
                  RatesCubit(currenciesRepo: context.read<CurrenciesRepo>())
                    ..init(),
        ),
      ],
      child: BlocConsumer<MainPageCubit, MainPageState>(
        listener: (context, state) {
          if (state is MainPageLoggedOut) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AuthPage()),
            );
          }
        },
        builder: (context, state) {
          final selectedIndex = state.selectedIndex;
          String appBarTitle = selectedIndex == 0 ? 'Rates' : 'Convert';
          return Scaffold(
            appBar: AppBar(
              leading:
                  selectedIndex == 0
                      ? IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          context.read<RatesCubit>().updateRates();
                        },
                      )
                      : null,
              title: Text(appBarTitle),
              centerTitle: selectedIndex == 0 ? true : false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    context.read<MainPageCubit>().onLoggedOut();
                  },
                ),
              ],
              automaticallyImplyLeading: false,
            ),
            body: IndexedStack(index: selectedIndex, children: _widgetOptions),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.show_chart),
                  label: 'Rates',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.swap_horiz),
                  label: 'Convert',
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                context.read<MainPageCubit>().onItemTapped(index);
              },
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
            ),
          );
        },
      ),
    );
  }
}
