import Tagged
import Testing
import Tree
import Tree_Column

@Suite
struct `Tree column behaviour` {
    @Test
    func `an empty tree has no root and no nodes`() {
        let tree = Tree<Int>()
        #expect(tree.isEmpty)
        #expect(tree.count == 0)
        #expect(tree.root == nil)
    }

    @Test
    func `inserted values are read back at their positions`() throws {
        var tree = Tree<Int>()
        let root = try tree.insert(0, at: .root)
        let left = try tree.insert(1, at: .child(of: root, at: 0))
        let right = try tree.insert(2, at: .child(of: root, at: 1))
        #expect(tree.count == 3)
        #expect(tree.peek(at: root) == 0)
        #expect(tree.peek(at: left) == 1)
        #expect(tree.peek(at: right) == 2)
    }

    @Test
    func `removing an interior subtree frees exactly that subtree`() throws {
        var tree = Tree<Int>()
        let root = try tree.insert(0, at: .root)
        let left = try tree.insert(1, at: .child(of: root, at: 0))
        let right = try tree.insert(2, at: .child(of: root, at: 1))
        let grandchild = try tree.insert(3, at: .child(of: left, at: 0))
        try tree.removeSubtree(at: left)
        #expect(tree.count == 2)
        #expect(tree.peek(at: root) == 0)
        #expect(tree.peek(at: right) == 2)
        #expect(tree.peek(at: left) == nil)
        #expect(tree.peek(at: grandchild) == nil)
    }

    @Test
    func `removing the root empties the tree`() throws {
        var tree = Tree<Int>()
        let root = try tree.insert(0, at: .root)
        _ = try tree.insert(1, at: .child(of: root, at: 0))
        try tree.removeSubtree(at: root)
        #expect(tree.isEmpty)
        #expect(tree.root == nil)
    }

    @Test
    func `a second root insertion is refused`() throws {
        var tree = Tree<Int>()
        _ = try tree.insert(0, at: .root)
        #expect(throws: (any Error).self) {
            _ = try tree.insert(1, at: .root)
        }
    }
}
