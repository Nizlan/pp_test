import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/auth_local_data_source/auth_local_data_source_impl.dart';
import 'data/datasources/auth_remote_data_source/auth_remote_data_source_impl.dart';
import 'data/datasources/currency_remote_data_source/currency_remote_data_source_mock.dart';
import 'data/repositories/auth_repo/auth_repo.dart';
import 'data/repositories/auth_repo/auth_repo_impl.dart';
import 'data/repositories/currencies_repo/currencies_repo.dart';
import 'data/repositories/currencies_repo/currencies_repo_impl.dart';
import 'ui/auth_page/view/auth_page.dart';
import 'ui/rates_page/cubit/rates_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepo>(
          create:
              (context) => AuthRepoImpl(
                authLocalDataSource: AuthLocalDataSourceSharedPref(
                  sharedPreferences: sharedPreferences,
                ),
                authRemoteDataSource: AuthRemoteDataSourceImpl(),
              ),
        ),
        RepositoryProvider<CurrenciesRepo>(
          create:
              (context) => CurrenciesRepoImpl(
                currencyRemoteDataSource: CurrencyRemoteDataSourceMock(),
              ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RatesCubit>(
            create:
                (context) =>
                    RatesCubit(currenciesRepo: context.read<CurrenciesRepo>()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const AuthPage(),
        ),
      ),
    );
  }
}
