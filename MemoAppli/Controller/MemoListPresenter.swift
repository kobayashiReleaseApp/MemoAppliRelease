//
//  MemoListPresenter.swift
//  MemoAppli
//
//  Created by 小林大希 on 2020/04/22.
//  Copyright © 2020 小林大希. All rights reserved.
//

import Foundation

class MemoListPresenter {
    weak var delegate: MemoListViewController?
    func showAlert() {
        Alert.showAlert(.edit, "メモ追加", "タイトルを入力してください", buttonTitle: "add", okAction: { (realm, obj, text) in
            if text == "" {
                Alert.showAlert(.warning, "", "\nタイトルを入力してください\n")
                return
            }
            obj.memoTitle = text
            realm.saveObject(obj: obj)
            self.delegate?.memoListView.tableReload()
        })
    }
}
