//
//  UIColorExtension.swift
//  Better me
//
//  Created by 심윤주 on 2023/01/25.
//

import Foundation
import UIKit

extension UIColor {
    @nonobjc class var BtnColor: UIColor {
        return UIColor(named: "custom_red")!
    }
    @nonobjc class var TextColor: UIColor {
        return UIColor(named: "text_color")!
    }
    @nonobjc class var OriginBtnColor: UIColor {
        return UIColor(named: "custom_gray")!
    }
    @nonobjc class var WhiteTextColor: UIColor {
        return UIColor.white
    }
}

