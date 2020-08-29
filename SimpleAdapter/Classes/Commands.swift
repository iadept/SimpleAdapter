//
//  Commands.swift
//  SimpleAdapter
//
//  Created by Mikhail Smetannikov on 27.03.2020.
//  Copyright © 2020 Mikhail Smetannikov. All rights reserved.

import UIKit

protocol Command {
    func perfrom(adapter: SATableViewAdapter)
}

class CommandInsert: Command {
    
    let to: SATableViewInsertPosition
    let item: SATableViewItem
    let animation: UITableView.RowAnimation
    
    init(item: SATableViewItem,
         to: SATableViewInsertPosition,
         animation: UITableView.RowAnimation) {
        self.to = to
        self.item = item
        self.animation = animation
    }
    
    func perfrom(adapter: SATableViewAdapter) {
        var indexPath: IndexPath?
        switch to {
        case .top:
            adapter.items.insert(item, at: 0)
            indexPath = IndexPath(row: 0, section: 0)
        case .index(let value):
            adapter.items.insert(item, at: value)
            indexPath = IndexPath(row: value, section: 0)
        case .after(let identifier):
            guard let index = adapter.index(forIdentifier: identifier) else { return }
            adapter.items.insert(item, at: index + 1)
            indexPath = IndexPath(row: index + 1, section: 0)
        case .before(let identifier):
            guard let index = adapter.index(forIdentifier: identifier) else { return }
            adapter.items.insert(item, at: index)
            indexPath = IndexPath(row: index, section: 0)
        case .bottom:
            indexPath = IndexPath(row: adapter.items.endIndex, section: 0)
            adapter.items.append(item)
        }
        if let indexPath = indexPath {
            adapter.tableView?.insertRows(at: [indexPath], with: animation)
        }
    }
}

class CommandRemoveItem: Command {
    
    let index: Int
    let animation: UITableView.RowAnimation
    
    init(index: Int,
         animation: UITableView.RowAnimation) {
        self.index = index
        self.animation = animation
    }
    
    func perfrom(adapter: SATableViewAdapter) {
        adapter.tableView?.deleteRows(at: [IndexPath(row: index, section: 0)], with: animation)
        adapter.items.remove(at: index)
    }
}

class CommandRemove: Command {
    
    let at: SATableViewRemovePosition
    let animation: UITableView.RowAnimation
    
    init(at: SATableViewRemovePosition,
         animation: UITableView.RowAnimation) {
        self.at = at
        self.animation = animation
    }
    
    func perfrom(adapter: SATableViewAdapter) {
        switch at {
        case .index(let value):
            adapter.tableView?.deleteRows(
                at: [IndexPath(row: value, section: 0)],
                with: animation)
            adapter.items.remove(at: value)
            
        case .item(let identifier):
            guard let index = adapter.index(forIdentifier: identifier) else { return }
            adapter.tableView?.deleteRows(
                at: [IndexPath(row: index, section: 0)],
                with: animation)
            adapter.items.remove(at: index)
        case .type(let value):
            for (index, item) in adapter.items.enumerated() {
                if(type(of: item) == value) {
                    adapter.tableView?.deleteRows(
                        at: [IndexPath(row: index, section: 0)],
                        with: animation)
                    adapter.items.remove(at: index)
                }
            }
        case .all:
            for (index, _) in adapter.items.enumerated() {
                adapter.tableView?.deleteRows(
                    at: [IndexPath(row: index, section: 0)],
                    with: animation)
                adapter.items.remove(at: 0)
            }
        }        
    }
}

class CommandUpdate: Command {
    
    let at: SATableViewUpdatePosition
    let item: SATableViewItem
    let animation: UITableView.RowAnimation
    
    init(item: SATableViewItem,
         at: SATableViewUpdatePosition,
         animation: UITableView.RowAnimation) {
        self.item = item
        self.at = at
        self.animation = animation
    }
    
    func perfrom(adapter: SATableViewAdapter) {
        switch at {
        case .index(let value):
            adapter.items[value] = item
            let indexPath = IndexPath(row: value, section: 0)
            adapter.tableView?.reloadRows(at: [indexPath], with: animation)
        case .item(let identifier):
            guard let index = adapter.index(forIdentifier: identifier) else { return }
            adapter.items[index] = item
            let indexPath = IndexPath(row: index, section: 0)
            adapter.tableView?.reloadRows(at: [indexPath], with: animation)
        }
    }
}
