//
//  SizeUtil.swift
//  ChatNoir
//
//  Created by fred on 24/11/2020.
//

import UIKit

class SizeUtil {
    
    func getPostTextSize(_ text: String, _ width: CGFloat) -> CGSize {
        let font = UIFont(name: "MarkerFelt-Thin", size: 17.0)
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let string = NSString(string: text)
        let box = string.boundingRect(with: size, options: options, attributes: [.font: font ?? UIFont.systemFont(ofSize: 17)], context: nil).size
        return box
    }
}
