// ignore_for_file: public_member_api_docs, sort_constructors_first
final class OnboardState {
  OnboardState(this.currentIndex);
  final int currentIndex;

  OnboardState copyWith({
    int? currentIndex,
  }) {
    return OnboardState(
      currentIndex ?? this.currentIndex,
    );
  }
}
