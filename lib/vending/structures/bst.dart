class BST {
  BSTNode? root;

  void insert(int key, int value) {
    root = _insert(root, key, value);
  }

  void update(int key, int value) {
    insert(key, value); // alias
  }

  BSTNode _insert(BSTNode? node, int key, int value) {
    if (node == null) return BSTNode(key, value);
    if (key < node.key) {
      node.left = _insert(node.left, key, value);
    } else if (key > node.key) {
      node.right = _insert(node.right, key, value);
    } else {
      node.value = value;
    }
    return node;
  }

  int? getValue(int key) => _getValue(root, key);

  int? _getValue(BSTNode? node, int key) {
    if (node == null) return null;
    if (key == node.key) return node.value;
    return key < node.key
        ? _getValue(node.left, key)
        : _getValue(node.right, key);
  }

  void inOrder(void Function(int key, int value) visit) {
    _inOrder(root, visit);
  }

  void _inOrder(BSTNode? node, void Function(int key, int value) visit) {
    if (node == null) return;
    _inOrder(node.left, visit);
    visit(node.key, node.value);
    _inOrder(node.right, visit);
  }
}
