//
//  MemoListView.swift
//  MemoAppli
//
//  Created by 小林大希 on 2020/04/22.
//  Copyright © 2020 小林大希. All rights reserved.
//

import UIKit

class MemoListView: UITableView {
    let realm = RealmManager()
    var translateAction: ((UIViewController) -> Void)!
    var longPressGesture: UILongPressGestureRecognizer!
    
    init() {
        
        super.init(frame: .zero, style: .plain)
        delegate = self
        dataSource = self
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(cellLongPressAction(_:)))
        self.addGestureRecognizer(longPressGesture)
    }
    
    // This method must be called.
    func setTranslateAction(translateAction action: @escaping (UIViewController) -> Void) {
        self.translateAction = action
    }
    
    func tableReload() {
        self.reloadData()
    }
    
    @objc func cellLongPressAction(_ longPressView: UILongPressGestureRecognizer) {
        let a = longPressView
        print(a)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == self {
            return nil
        }
        return view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MemoListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MemoBodyViewController()
        let obj = realm.getObject()
        vc.memoParams = obj[indexPath.row]
        translateAction(vc)
    }
}

extension MemoListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.getObject().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.backgroundColor = .white
        let title = realm.getObject()
        cell.textLabel?.text = title[indexPath.row].memoTitle
        cell.textLabel?.textColor = .black
        let cellTapedBackColor = UIView()
        cellTapedBackColor.backgroundColor = .lightGray
        cell.selectedBackgroundView = cellTapedBackColor
        realm.updateObject(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") { (action, view, boolValue) in
            self.realm.removeSeachObject(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let updateItem = UIContextualAction(style: .normal, title: "Edit") { (action, view, boolValue) in
            Alert.showAlert(.edit, "タイトル変更", "タイトルを入力してください", buttonTitle: "OK", okAction: { (realm, obj, text) in
                if text == "" {
                    Alert.showAlert(.warning, "", "\nタイトルを入力してください\n")
                    return
                }
                realm.updateObject(index: indexPath.row, title: text)
                tableView.reloadData()
            })
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem, updateItem])
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
