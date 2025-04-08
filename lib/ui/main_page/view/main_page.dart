import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth_page/view/auth_page.dart';
import '../../convert_page/view/convert_page.dart';
import '../../rates_page/cubit/rates_page_cubit.dart';
import '../../rates_page/view/rates_page.dart';
import '../cubit/main_page_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const List<Widget> _widgetOptions = <Widget>[
    RatesPage(),
    ConvertPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainPageCubit(),
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
                          context.read<RatesPageCubit>().updateRates();
                        },
                      )
                      : null,
              title: Text(appBarTitle),
              centerTitle: true,
              actions:
                  selectedIndex == 0
                      ? [
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            context.read<MainPageCubit>().onLoggedOut();
                          },
                        ),
                      ]
                      : null,
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
