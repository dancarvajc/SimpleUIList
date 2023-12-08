import SwiftUI

/// Simple `UITableView` implementation for use in SwiftUI tailored for a chat app. It serves as a list and only supports one section.
/// - Parameters:
///   - data: The information to be displayed in the table.
///   - content: The view for each row.
public struct SimpleUIList<Cell: View, ItemType: Identifiable>: UIViewControllerRepresentable {
    private let data: [ItemType]
    private let content: (ItemType) -> Cell
    private var reversedEnabled: Bool = false
    private var startAtBottom: Bool = false
    private let onDataRefresh: ((UITableView) -> Void)?
    private let chatMode: Bool

    /// Initializer with chat mode enabled by default.
    /// - Parameters:
    ///   - data: The information to be displayed in the table.
    ///   - content: The view for each row.
    public init(_ data: [ItemType],
                @ViewBuilder content: @escaping (ItemType) -> Cell)
    {
        self.data = data
        self.content = content
        self.onDataRefresh = nil
        self.chatMode = true
    }

    /// Initializer that allows a custom action to be performed when the input data changes.
    /// - Parameters:
    ///   - data: The information to be displayed in the table.
    ///   - content: The view for each row.
    ///   - onDataRefresh: The action to perform when the input data is refreshed.
    public init(_ data: [ItemType],
                @ViewBuilder content: @escaping (ItemType) -> Cell,
                onDataRefresh: @escaping (UITableView) -> Void)
    {
        self.data = data
        self.content = content
        self.chatMode = false
        self.onDataRefresh = onDataRefresh
    }

    public func makeUIViewController(context _: Context) -> TableViewController<Cell, ItemType> {
        return TableViewController<Cell, ItemType>(reversedEnabled: reversedEnabled, content: content)
    }

    public func updateUIViewController(_ uiViewController: TableViewController<Cell, ItemType>, context _: Context) {
        if !chatMode {
            onDataRefresh?(uiViewController.tableView)
        } else {
            guard !data.isEmpty else { return }
            if uiViewController.isFirstAppearing {
                uiViewController.updateData(with: data, shouldScrollToBottom: startAtBottom, animated: false)
            } else {
                if data.count != uiViewController.data.count {
                    uiViewController.updateData(with: data, shouldScrollToBottom: true, animated: true)
                } else {
                    uiViewController.updateData(with: data, shouldScrollToBottom: false)
                }
            }
        }
    }
}

// MARK: Custom modifiers

public extension SimpleUIList {
    func startAtBottom(_ value: Bool) -> Self {
        var newInstance = self
        newInstance.startAtBottom = value
        return newInstance
    }

    func reverseList(_ value: Bool) -> Self {
        var newInstance = self
        newInstance.reversedEnabled = value
        return newInstance
    }
}
