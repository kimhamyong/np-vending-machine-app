class Stack<T> {
  final List<T> _stack = [];

  void push(T value) => _stack.add(value);

  T? pop() {
    if (isEmpty) return null;
    return _stack.removeLast();
  }

  T? peek() => isEmpty ? null : _stack.last;

  bool get isEmpty => _stack.isEmpty;

  int get length => _stack.length;

  void clear() => _stack.clear();

  List<T> toList() => List.from(_stack);
}
