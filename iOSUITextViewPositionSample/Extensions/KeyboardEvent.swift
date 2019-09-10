//
//  KeyboardEvent.swift
//  iOSUITextViewPositionSample
//
//  Created by Yuki Okudera on 2019/09/10.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

/// キーボード表示/非表示の通知を受け取った時に実行するSelectorでコールする処理を定義
@objc protocol KeyboardEvent: class {
    
    @objc func keyboardWillShow(_ notification: Notification)
    @objc func keyboardWillHide(_ notification: Notification)
}
