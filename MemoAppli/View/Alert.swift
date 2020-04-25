//
//  Alert.swift
//  MemoAppli
//
//  Created by 小林大希 on 2020/04/22.
//  Copyright © 2020 小林大希. All rights reserved.
//

import UIKit
import SCLAlertView

struct Alert {
    enum AlertType {
        case edit
        case warning
    }
    
    static func showAlert(_ alertType: AlertType, _ title: String, _ subTitle: String, buttonTitle: String = "OK", okAction: ((RealmManager, MemoParams, String) -> Void)? = nil, cancelAction: @escaping () -> Void = {}) {
        let realm = RealmManager()
        let obj = MemoParams()
        var textField: UITextField? = nil
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
        let alert = SCLAlertView(appearance: appearance)
        
        if let okAction = okAction {
            alert.addButton(buttonTitle, action: {
                guard let text = textField?.text else {
                    return
                }
                okAction(realm, obj, text)
            })
        }
        
        alert.addButton("close", action: cancelAction)
        
        switch alertType {
        case .warning:
            alert.showWarning(title, subTitle: subTitle)
            return
        case .edit:
            textField = alert.addTextField("タイトル")
            textField?.textColor = .black
            textField?.backgroundColor = .white
            alert.showEdit(title, subTitle: subTitle)
        }
    }
}
