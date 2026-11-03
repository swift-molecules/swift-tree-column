# swift-tree-column

Use this package when you need a tree in which any node can have any number of children, kept in order and addressed by index: document outlines, file hierarchies, syntax trees, UI view trees. Start from `Tree<Element>`, which is `__Tree<TreeStorage.Dynamic<Element>>`, and insert children with `.child(of:at:)`. Use swift-tree-n instead when every node has a fixed number of child slots (binary trees included), swift-tree-keyed when children are named by a hashable key, and swift-tree for code that should work over any tree layout. The general tree laws (stale positions, a single root, leaf-only `remove(at:)`, `removeSubtree(at:)`, traversal order and `height`) are in swift-tree.

## Laws

- A node's children form a list. Inserting a child at index `i` accepts any `i` from 0 up to and including the current child count, so inserting at the child count appends. The child already at `i` and every later sibling move up by one index. Only an index past the child count fails; an index is never "occupied".
- Removing a child, with `remove(at:)` or `removeSubtree(at:)`, closes the gap: every later sibling moves down by one index. A child's index can therefore change while its `__TreePosition` stays valid. `child.at(_:of:)` returns `nil` for an index outside the current children.
- All nodes live in one generational slot arena. When the arena is full its capacity doubles, and `minimumCapacity` reserves at least one slot up front. A position stays valid when the arena grows.
- Copies are copy-on-write. Reads never copy; the first mutation of a tree whose storage is shared copies the whole arena, so mutating a copy leaves the original unchanged.
