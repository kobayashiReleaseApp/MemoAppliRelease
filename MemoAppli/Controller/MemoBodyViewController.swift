//
//  MemoBodyViewController.swift
//  MemoAppli
//
//  Created by 小林大希 on 2020/04/22.
//  Copyright © 2020 小林大希. All rights reserved.
//

import UIKit

class MemoBodyViewController: UIViewController {
    let realm = RealmManager()
    var naviBarHeight: CGFloat = 0
    // 画面遷移時に値を受け取る
    var memoParams: MemoParams!
    var bodyTextView: MemoBodyTextView!
    var bottomAnchor: NSLayoutConstraint!
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        let statusbarHieght = UIApplication.shared.statusBarFrame.height
        
        naviBarHeight = (navigationController?.navigationBar.frame.size.height)!
        
        bodyTextView = MemoBodyTextView(memoParams.memoBody)        
        view.addSubview(bodyTextView)
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        bodyTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: naviBarHeight+statusbarHieght+10).isActive = true
        bottomAnchor = bodyTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)//.isActive = true
        bottomAnchor.isActive = true
        bodyTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        bodyTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarWillHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        bodyTextView.isScrollEnabled = false
        let rect = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        bottomAnchor.constant = -rect!.height
        bodyTextView.isScrollEnabled = true
    }
    
    @objc func keyboarWillHidden(_ notification: Notification) {
        bottomAnchor.constant = -70
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // なんでかわからんけど長文を書いた view を表示されると少しスクロールされた状態で表示されるのでスクロール位置を0に戻して回避
        bodyTextView.setContentOffset(.zero, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let obj = realm.getObject().first(where: { obj -> Bool in
            return obj.index == memoParams.index && obj.memoTitle == memoParams.memoTitle && obj.memoBody == memoParams.memoBody
        })
        realm.updateObject(obj: obj!, body: bodyTextView.text)
    }
}
