//
//  SATableViewUpdater.swift
//  SimpleAdapter
//
//  Created by Mikhail Smetannikov on 27.03.2020.
//  Copyright © 2020 Mikhail Smetannikov. All rights reserved.
//

import UIKit

public enum SATableViewInsertPosition {
    case top
    case index(value: Int)
    case after(itemIdentifier: String)
    case before(itemIdentifier: String)
    case bottom
}

public enum SATableViewUpdatePosition {
    case index(value: Int)
    case item(identifier: String)
}

public enum SATableViewRemovePosition {
    case index(value: Int)
    case item(identifier: String)
    case type(value: SATableViewItem.Type)
    case all
}

public enum SATableViewUpdaterCommand {
    case insert(
        item: SATableViewItem,
        to: SATableViewInsertPosition,
        animation: UITableView.RowAnimation)
    case remove(
        at: SATableViewRemovePosition,
        animation: UITableView.RowAnimation)
    case update(
        item: SATableViewItem,
        at: SATableViewUpdatePosition,
        animation: UITableView.RowAnimation)
}

public class SATableViewUpdater {

    private var commands = [Command]()
    private let adapter: SATableViewAdapter

    init(adapter: SATableViewAdapter) {
        self.adapter = adapter
    }

    init(adapter: SATableViewAdapter, commands: [SATableViewUpdaterCommand]) {
        self.adapter = adapter
        for command in commands {
            switch command {
            case .insert(let item, let to, let animation):
                insert(item: item, to: to, animation: animation)
            case .remove(let at, let animation):
                remove(at: at, animation: animation)
            case .update(let item, let at, let animation):
                update(item: item, at: at, animation: animation)
            }
        }
    }

    public func insert(
        item: SATableViewItem,
        to: SATableViewInsertPosition,
        animation: UITableView.RowAnimation
    ) {
        commands.append(CommandInsert(
            item: item,
            to: to,
            animation: animation))
    }

    public func remove(at: SATableViewRemovePosition, animation: UITableView.RowAnimation) {
        commands.append(CommandRemove(
            at: at,
            animation: animation))
    }

    public func update(
        item: SATableViewItem,
        at: SATableViewUpdatePosition,
        animation: UITableView.RowAnimation
    ) {
        commands.append(CommandUpdate(
            item: item,
            at: at,
            animation: animation))
    }

    public func perform() {
        for command in commands {
            adapter.tableView?.beginUpdates()
            command.perfrom(adapter: adapter)
            adapter.tableView?.endUpdates()
        }
        commands.removeAll()
    }
}
