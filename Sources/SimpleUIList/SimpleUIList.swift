import SwiftUI

/// Simple UITableView implementation for use in SwitUI oriented to a chat app. It is used as a list and only supports 1 section.
/// - Parameters:
///   - data: Your information to be displayed en the Table.
///   - content: The row view.
public struct SimpleUIList<Cell: View, ItemType: Identifiable>: UIViewControllerRepresentable {
    private let data: [ItemType]
    private let content: (ItemType) -> Cell
    private var reversedEnabled: Bool = false
    private var startAtBottom: Bool = false

    public init(_ data: [ItemType], @ViewBuilder content: @escaping (ItemType) -> Cell) {
        self.data = data
        self.content = content
    }

    public func makeUIViewController(context _: Context) -> TableViewController<Cell, ItemType> {
        return TableViewController<Cell, ItemType>(reversedEnabled: reversedEnabled, content: content)
    }

    public func updateUIViewController(_ uiViewController: TableViewController<Cell, ItemType>, context _: Context) {
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
