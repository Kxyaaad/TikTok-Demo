//
//  ScaleAnimateButton.swift
//  TikTok
//
//  Created by Mac on 2020/6/24.
//  Copyright © 2020 Kxy. All rights reserved.
//

import UIKit

class ScaleAnimateButton: UIButton {
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        //添加一个点击事件
        addTarget(self, action: #selector(toggleSelected), for: .touchUpInside)
    }
    
    @objc
    func toggleSelected() {
        isSelected.toggle()
        
    }
    
    override var isSelected: Bool {
        get {
            super.isSelected
        }
        
        set {
            super.transform = .init(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [.beginFromCurrentState, .transitionCrossDissolve]) {
                super.isSelected = newValue
                super.transform = .identity
            } completion: { (_) in
                
            }

        }
    }
}
