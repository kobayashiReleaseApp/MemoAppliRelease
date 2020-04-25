//
//  MemoListViewController.swift
//  MemoAppli
//
//  Created by 小林大希 on 2020/04/22.
//  Copyright © 2020 小林大希. All rights reserved.
//

import UIKit

class MemoListViewController: UIViewController {
    let memoListPresenter: MemoListPresenter = MemoListPresenter()
    var naviBarHeight: CGFloat = 0
    let memoListView: MemoListView = MemoListView()
    
    override func loadView() {
        super.loadView()
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        print(statusBarHeight)
        
        view.backgroundColor = .white
        memoListPresenter.delegate = self
        // ナビゲーションバー
        naviBarHeight = (navigationController?.navigationBar.frame.size.height)!
        guard let appliTitle = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String else {
            return
        }
        navigationItem.title = appliTitle
        let rightNaviBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapRightNaviBtn))
        navigationItem.setRightBarButton(rightNaviBtn, animated: true)
        
        // メモリスト
        memoListView.setTranslateAction { vc in
            self.navigationController?.pushViewController(vc, animated: true)
        }
        memoListView.backgroundColor = .white
        view.addSubview(memoListView)
        memoListView.translatesAutoresizingMaskIntoConstraints = false
        memoListView.topAnchor.constraint(equalTo: view.topAnchor, constant: naviBarHeight+statusBarHeight).isActive = true
        memoListView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        memoListView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        memoListView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    @objc func didTapRightNaviBtn() {
        memoListPresenter.showAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
