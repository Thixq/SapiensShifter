class OnboardState {
  OnboardState(this.currentIndex, {required this.isLastPage});

  factory OnboardState.initial() {
    return OnboardState(0, isLastPage: false);
  }
  final int currentIndex;
  final bool isLastPage;

  OnboardState copyWith({
    int? currentIndex,
    bool? isLastPage,
  }) {
    return OnboardState(
      currentIndex ?? this.currentIndex,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }
}
