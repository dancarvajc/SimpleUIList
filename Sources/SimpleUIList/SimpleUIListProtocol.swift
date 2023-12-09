//
//  SimpleUIListProtocol.swift
//
//
//  Created by Daniel Carvajal on 08-12-23.
//

import UIKit

public protocol SimpleUIListProtocol {
    associatedtype ItemType: Identifiable
    var tableView: UITableView { get }
    var data: [ItemType] { get set }
    var isFirstAppearing: Bool { get set }
}
