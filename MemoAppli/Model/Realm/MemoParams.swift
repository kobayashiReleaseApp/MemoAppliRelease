//
//  MemoParams.swift
//  MemoAppli
//
//  Created by 小林大希 on 2020/04/22.
//  Copyright © 2020 小林大希. All rights reserved.
//

import RealmSwift

class MemoParams: Object {
    @objc dynamic var index: Int = 0
    @objc dynamic var memoTitle: String = ""
    @objc dynamic var memoBody: String = ""
}
