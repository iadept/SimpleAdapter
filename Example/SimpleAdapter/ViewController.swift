//
//  ViewController.swift
//  SimpleAdapter
//
//  Created by iadept on 03/28/2020.
//  Copyright (c) 2020 iadept. All rights reserved.
//

import UIKit
import SimpleAdapter

enum ItemIdentifier: String {
    case addButton
}

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView?

    private var adapter: SATableViewAdapter?
    private var textFieldItem: TextFieldItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let tableView = tableView else { return }
        adapter = SATableViewAdapter(tableView: tableView)
        
        let emptyView = UILabel()
        emptyView.text = "Empty table!"
        adapter?.emptyView = emptyView
        
        adapter?.register(cell: TextCell.self, withIdentifier: TextCell.cellIdentifier)
        adapter?.register(cell: ButtonCell.self, withIdentifier: ButtonCell.cellIdentifier)
        adapter?.register(cell: TextFieldCell.self, withIdentifier: TextFieldCell.cellIdentifier)

        adapter?.set(items: [])

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.adapter?.set(items: [TextItem(text: "Hello")])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            guard let updater = self.adapter?.makeUpdater() else { return }
            updater.remove(atIndex: 0, animation: .fade)
            updater.insert(item: TextItem(text: "4"), to: .bottom, animation: .fade)
            updater.insert(item: TextItem(text: "3"), to: .bottom, animation: .fade)
            updater.insert(item: TextItem(text: "2"), to: .top, animation: .fade)
            updater.insert(item: TextItem(text: "1"), to: .top, animation: .fade)
            updater.perform()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            let buttonCellItem = ButtonItem(
                identifier: .addButton,
                title: "Add cell",
                delegate: self)
            self.adapter?.update([
                .update(item: buttonCellItem, at: .index(value: (self.adapter?.count ?? 1) - 1), animation: .automatic)
            ])
        }
    }
}

extension ViewController: ButtonItemDelegate {
    func buttonItemDidTap(_ item: ButtonItem) {
        // You may save link to item or get it by adapter.item(forIdentifier:)
        if let textFieldItem = textFieldItem {
            self.adapter?.update([
                .insert(item: TextItem(text: "Text: \(textFieldItem.value)"), to: .top, animation: .top)
            ])
        } else {
            let textFieldItem = TextFieldItem(placeholder: "Input text and press add", delegate: self)
            self.adapter?.update([
                .insert(item: TextItem(text: "Did Tap"), to: .top, animation: .top),
                .insert(item: textFieldItem, to: .before(itemIdentifier: "addButton"), animation: .fade)
            ])
            self.textFieldItem = textFieldItem
        }
    }
}

extension ViewController: TextFieldItemDelegate {
    func textFieldItem(_ item: TextFieldItem, didChangeValue value: String) {
        // Get item by id
        guard let buttonItem = adapter?.item(
            forIdentifier: ItemIdentifier.addButton.rawValue) as? ButtonItem else { return }
        buttonItem.isEnabled = !value.isEmpty
    }
}
