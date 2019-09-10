//
//  TextViewKeyboardEventObservable.swift
//  iOSUITextViewPositionSample
//
//  Created by Yuki Okudera on 2019/09/10.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

/// テキストビューのキーボード監視
protocol TextViewKeyboardEventObservable: KeyboardEvent {
    
    var textView: UITextView! { get }
    
    func addKeyboardEventObservers()
    func removeKeyboardEventObservers()
    
    func keyboardShowAction(_ notification: Notification)
    func keyboardHideAction(_ notification: Notification)
}

extension TextViewKeyboardEventObservable where Self: UIViewController {
    
    func addKeyboardEventObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func removeKeyboardEventObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func keyboardShowAction(_ notification: Notification) {
        
        guard
            let userInfo = notification.userInfo as? [String: Any],
            let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
                return
        }
        
        // Set keyboard topY and height.
        KeyboardConst.keyboardTopY = keyboardInfo.cgRectValue.origin.y
        KeyboardConst.keyboardHeight = keyboardInfo.cgRectValue.size.height
    }
    
    func keyboardHideAction(_ notification: Notification) {
        textView.contentInset = .zero
        textView.scrollIndicatorInsets = .zero
    }
}

