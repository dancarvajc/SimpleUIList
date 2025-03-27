//
//  TableViewController.swift
//
//
//  Created by Daniel Carvajal on 03-12-23.
//

import SwiftUI
import UIKit

public final class TableViewController<Cell: View, ItemType: Identifiable>: UIViewController, UITableViewDataSource, SimpleUIListProtocol {
    private let content: (ItemType) -> Cell
    private let reversedEnabled: Bool
    public var data: [ItemType] = []
    public var tableView = UITableView()
    public var isFirstAppearing = true

    public init(reversedEnabled: Bool, @ViewBuilder content: @escaping (ItemType) -> Cell) {
        self.reversedEnabled = reversedEnabled
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }

    private func prepare() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .interactive
        tableView.register(cellClass: HostingTableViewCell<Cell>.self)
        if reversedEnabled {
            tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        }

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func updateData(with newData: [ItemType], shouldScrollToBottom: Bool, animated: Bool = false) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            data = newData
            if isFirstAppearing {
                isFirstAppearing = false
                guard shouldScrollToBottom else {
                    tableView.reloadData()
                    return
                }
                scrollToBottom(animated: animated)
            } else if shouldScrollToBottom {
                scrollToBottom(animated: animated)
            } else {
                tableView.reloadDataAndKeepOffset()
            }
        }
    }

    private func scrollToBottom(animated: Bool) {
        let indexPath = IndexPath(row: reversedEnabled ? 0 : data.count - 1, section: 0)
        tableView.reloadData()
        tableView.scrollToRow(at: indexPath, at: reversedEnabled ? .top : .bottom, animated: animated)
    }

    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HostingTableViewCell<Cell> = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let message = data[indexPath.row]
        let content = content(message)
        cell.set(rootView: content, parentController: self)
        if reversedEnabled {
            cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        }
        return cell
    }
}
