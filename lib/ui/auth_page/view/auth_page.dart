import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/auth_repo/auth_repo.dart';
import '../cubit/auth_page_cubit.dart';
import '../../../ui/main_page/view/main_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => AuthPageCubit(context.read<AuthRepo>())..init(),
      child: BlocConsumer<AuthPageCubit, AuthPageState>(
        listener: (context, state) {
          if (state is AuthPageSuccess) {
            Navigator.of(context).pushReplacement(
              state.animateTransition
                  ? MaterialPageRoute(builder: (context) => const MainPage())
                  : PageRouteBuilder(
                    pageBuilder:
                        (context, animation1, animation2) => const MainPage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
            );
          }
          if (state is AuthPageError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AuthPageInitializing) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                    const Text('Login'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 20),
                    const Text('Password'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthPageCubit>().tryLogin(
                            emailController.text,
                            passwordController.text,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFF0166FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child:
                            state is AuthPageLoading
                                ? Center(
                                  child: const CircularProgressIndicator(
                                    constraints: BoxConstraints(
                                      maxHeight: 20,
                                      maxWidth: 20,
                                      minHeight: 20,
                                      minWidth: 20,
                                    ),
                                  ),
                                )
                                : const Text('Sign in'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
