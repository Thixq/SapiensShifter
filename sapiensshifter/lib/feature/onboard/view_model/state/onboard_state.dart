// ignore_for_file: public_member_api_docs, sort_constructors_first
class OnboardState {
  OnboardState(this.currentIndex, {required this.isLastPage});
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
