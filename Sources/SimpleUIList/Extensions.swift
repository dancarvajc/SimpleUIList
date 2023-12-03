//
//  Extensions.swift
//
//
//  Created by Daniel Carvajal on 03-12-23.
//

import UIKit

extension UITableView {
    // MARK: Reference https://stackoverflow.com/a/46676973

    func reloadDataAndKeepOffset() {
        setContentOffset(contentOffset, animated: false)
        let beforeContentSize = contentSize
        reloadData()
        layoutIfNeeded()
        let afterContentSize = contentSize
        let newOffset = CGPoint(
            x: contentOffset.x + (afterContentSize.width - beforeContentSize.width),
            y: contentOffset.y + (afterContentSize.height - beforeContentSize.height)
        )
        setContentOffset(newOffset, animated: false)
    }

    func register(cellClass: (some UITableViewCell).Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.defaultIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultIdentifier)")
        }
        return cell
    }
}

extension UITableViewCell {
    static var defaultIdentifier: String {
        String(describing: self)
    }
}
