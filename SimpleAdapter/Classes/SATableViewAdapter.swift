//
//  SATableViewAdapter.swift
//  TablePresenter
//
//  Created by Mikhail Smetannikov on 27.03.2020.
//  Copyright © 2020 Mikhail Smetannikov. All rights reserved.
//

import UIKit

public class SATableViewAdapter: NSObject {

    weak var tableView: UITableView?
    var items: [SATableViewItem]
    public var count: Int { return items.count }
    public weak var emptyView: UIView?

    public init(tableView: UITableView) {
        items = []
        super.init()
        tableView.dataSource = self
        self.tableView = tableView
    }

    public func register(cell: SATableViewCell.Type, withIdentifier identifier: String) {
        let bundle = Bundle(for: cell)
        let nib = UINib(nibName: String(describing: cell), bundle: bundle)
        tableView?.register(nib, forCellReuseIdentifier: identifier)
    }

    public func set(items: [SATableViewItem]) {
        self.items = items
        tableView?.reloadData()
    }

    public func item(forIdentifier identifier: String) -> SATableViewItem? {
        return items.first { $0.itemIdentifier == identifier }
    }

    public func index(forIdentifier identifier: String) -> Int? {
        return items.firstIndex { $0.itemIdentifier == identifier }
    }

    public func makeUpdater() -> SATableViewUpdater {
        return SATableViewUpdater(adapter: self)
    }

    public func update(_ commands: [SATableViewUpdaterCommand]) {
        let updater = SATableViewUpdater(adapter: self, commands: commands)
        updater.perform()
    }
}

// MARK: - UITableViewDataSource
extension SATableViewAdapter: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = items.isEmpty ? emptyView : nil
        return items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier) as? SATableViewCell else {
            debugPrint("Cannot find cell with identifier: \(item.cellIdentifier)")
            return UITableViewCell()
        }
        cell.set(item: item)
        item.set(cell: cell)
        return cell
    }
}
