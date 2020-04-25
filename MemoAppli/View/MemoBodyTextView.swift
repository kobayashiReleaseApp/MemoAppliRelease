//
//  MemoBodyTextView.swift
//  MemoAppli
//
//  Created by 小林大希 on 2020/04/23.
//  Copyright © 2020 小林大希. All rights reserved.
//

import UIKit

class MemoBodyTextView: UITextView {
    let toolBar = UIToolbar()
    
    init(_ text: String) {
        super.init(frame: .zero, textContainer: nil)
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let commitBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapCommitBtn))
        toolBar.items = [spacer,commitBtn]
        font = UIFont.systemFont(ofSize: 20)
        textColor = .black
        backgroundColor = .white
        inputAccessoryView = toolBar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapCommitBtn() {
        resignFirstResponder()
    }
}
