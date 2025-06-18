class CustomQueue<T> {
  final List<T> _queue = [];

  void enqueue(T value) => _queue.add(value);

  T? dequeue() {
    if (isEmpty) return null;
    return _queue.removeAt(0);
  }

  T? peek() => isEmpty ? null : _queue.first;

  bool get isEmpty => _queue.isEmpty;

  int get length => _queue.length;

  void clear() => _queue.clear();

  List<T> toList() => List.from(_queue);
}
