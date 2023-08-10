abstract class BasePage<T> {
  final int count;
  final int? next;
  final int? previous;
  final List<T> results;

  BasePage({
    this.count = 0,
    this.next,
    this.previous,
    this.results = const [],
  });

  bool get hasNext => next != null;

  bool get hasPrevious => previous != null;
}
