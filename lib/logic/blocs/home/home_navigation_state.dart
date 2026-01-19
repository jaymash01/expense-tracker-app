class HomeNavigationState {
  final int index;

  const HomeNavigationState({this.index = 0});

  HomeNavigationState copyWith({int? index}) {
    return HomeNavigationState(index: index ?? this.index);
  }
}
