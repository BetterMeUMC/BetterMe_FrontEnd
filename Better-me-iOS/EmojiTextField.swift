//
//  EmojiTextField.swift
//  Better-me-iOS
//
//  Created by 정태우 on 2023/01/10.
//

import UIKit

class EmojiTextField: UITextField {
    override var textInputContextIdentifier: String? { "" }

    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }

}
