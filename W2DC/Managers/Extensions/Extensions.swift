//
//  Extensions.swift
//  W2DC
//
//  Created by Ninja on 9/10/18.
//  Copyright © 2018 Ninja. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setCardView(view : UIView){
        
        view.layer.cornerRadius = 5.0
        view.layer.borderColor  =  UIColor.clear.cgColor
        view.layer.borderWidth = 5.0
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor =  UIColor.lightGray.cgColor
        view.layer.shadowRadius = 5.0
        view.layer.shadowOffset = CGSize(width:5, height: 5)
        view.layer.masksToBounds = true
        
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
}

extension UILabel {
    
    func collapseLabel(with lines:String) {
        if self.numberOfLines == 2 {
            let h = self.text?.height(withConstrainedWidth: self.frame.size.width, font: self.font)
            let warray = lines.split(separator: " ")
            let line = Int(h!/self.font.pointSize)
            let wordsperLine = warray.count/line
            var tempString=""
            if(line>1){
                for i in 0...wordsperLine*2{
                    tempString.append(" "+String(warray[i]))
                }
                let mutableString = NSMutableAttributedString(string: tempString)
                mutableString.append(NSAttributedString(string: "...more", attributes: [NSAttributedStringKey.foregroundColor : UIColor.blue]))
                self.attributedText = mutableString
            }
            else
            {
                self.text = lines
            }
        }
    }
}

extension UIColor {
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            return nil
        }
        self.init(red: red, green: green, blue:  blue, alpha: alpha)
    }
}
