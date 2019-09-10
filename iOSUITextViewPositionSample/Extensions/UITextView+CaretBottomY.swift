//
//  UITextView+CaretBottomY.swift
//  iOSUITextViewPositionSample
//
//  Created by YukiOkudera on 2019/09/10.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

extension UITextView {

    /// caretのbottomのY座標を取得する
    ///
    /// textViewDidBeginEditingで呼び出す
    func currentCaretBottomY(completion: @escaping (CGFloat) -> ()) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            DispatchQueue.main.async { [weak self] in
                guard let weakSelf = self else {
                    return
                }
                guard let selectedRange = weakSelf.selectedTextRange else {
                    return
                }
                let caretRect = weakSelf.caretRect(for: selectedRange.start)
                let caretRectInWindow = weakSelf.convert(caretRect, to: nil)
                let caretBottomY = caretRectInWindow.origin.y + caretRectInWindow.size.height
                completion(caretBottomY)
            }
        }
    }
}
