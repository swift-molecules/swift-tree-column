public import Storage_Generational
public import Store

@usableFromInline
struct __TreeNode<Element: ~Copyable, ChildLinks>: ~Copyable {

    @usableFromInline var element: Element

    @usableFromInline var links: ChildLinks

    @usableFromInline var parentHandle: Store::Store.Generational.Handle?

    @usableFromInline
    init(
        element: consuming Element,
        links: consuming ChildLinks,
        parentHandle: Store::Store.Generational.Handle?
    ) {
        self.element = element
        self.links = links
        self.parentHandle = parentHandle
    }
}

extension __TreeNode: Copyable where Element: Copyable, ChildLinks: Copyable {}

extension __TreeNode: Sendable where Element: Sendable, ChildLinks: Sendable {}
