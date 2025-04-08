part of 'main_page_cubit.dart';

@immutable
sealed class MainPageState {
  final int selectedIndex;
  const MainPageState({required this.selectedIndex});
}

final class MainPageInitial extends MainPageState {
  const MainPageInitial(int selectedIndex)
    : super(selectedIndex: selectedIndex);
}

final class MainPageLoggedOut extends MainPageState {
  const MainPageLoggedOut(int selectedIndex)
    : super(selectedIndex: selectedIndex);
}
