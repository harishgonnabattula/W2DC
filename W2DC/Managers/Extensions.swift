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
            let lines = h!/self.font.pointSize
            let wordsperLine = warray.count/Int(lines)
            var tempString=""
            for i in 0...wordsperLine*2{
                tempString.append(" "+String(warray[i]))
            }
            let mutableString = NSMutableAttributedString(string: tempString)
            mutableString.append(NSAttributedString(string: "...more", attributes: [NSAttributedStringKey.foregroundColor : UIColor.blue]))
            self.attributedText = mutableString
        }
    }
}
