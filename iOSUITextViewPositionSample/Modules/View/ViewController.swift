//
//  ViewController.swift
//  iOSUITextViewPositionSample
//
//  Created by YukiOkudera on 2019/09/10.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    // 編集開始位置を含む行をマークするView(デバッグ用)
    var markView: UIView?

    @IBOutlet weak var textView: UITextView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardEventObservers()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardEventObservers()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textView.isFirstResponder {
            textView.resignFirstResponder()
        }
    }
}

// MARK: - TextViewKeyboardEventObservable
extension ViewController: TextViewKeyboardEventObservable {

    @objc func keyboardWillShow(_ notification: Notification) {
        keyboardShowAction(notification)
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        keyboardHideAction(notification)
    }
}

// MARK: - UITextViewDelegate
extension ViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {

        #if DEBUG
        // デバッグ用に編集開始位置を含む行を塗り潰す
        caretMarkView(textView)
        #endif

        textView.currentCaretBottomY { y in
            print("y", y)
            if KeyboardConst.keyboardTopY < y {
                print("編集開始位置が隠れている!!")
                // TextViewをずらす(キーボードの高さ分)
                let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: KeyboardConst.keyboardHeight, right: 0)
                UIView.animate(withDuration: 1.0, animations: {
                    self.textView.contentInset = contentInsets
                    self.textView.scrollIndicatorInsets = contentInsets
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
}

// MARK: - For debug
extension ViewController {

    func caretMarkView(_ textView: UITextView) {
        #if DEBUG
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            DispatchQueue.main.async {

                if let selectedRange = textView.selectedTextRange {
                    let caretRect = textView.caretRect(for: selectedRange.start)
                    let caretRectInWindow = textView.convert(caretRect, to: nil)
                    let caretLineRect = CGRect(x: 0,
                                               y: caretRectInWindow.origin.y,
                                               width: self.view.frame.width,
                                               height: caretRectInWindow.size.height)
                    self.markView?.removeFromSuperview()
                    self.markView = UIView(frame: caretLineRect)
                    self.markView!.backgroundColor = .blue
                    self.view.addSubview(self.markView!)
                }
            }
        }
        #endif
    }
}
