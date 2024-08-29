//
//  CustomTextField.swift
//  HouseHub
//
//  Created by Антон Павлов on 29.08.2024.
//

import UIKit

final class CustomTextField: UITextField {
    
    var iconSize: CGSize = CGSize(width: 16, height: 16)
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset: CGFloat = 10
        let yOffset = (bounds.height - iconSize.height) / 2
        return CGRect(x: offset, y: yOffset, width: iconSize.width, height: iconSize.height)
    }
}
