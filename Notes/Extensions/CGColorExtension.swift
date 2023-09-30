//
//  CGColorExtension.swift
//  Notes
//
//  Created by Porfirio Diaz on 26/09/23.
//

import Foundation
import UIKit


public extension CGColor {
    var UIColor : UIKit.UIColor {
        return UIKit.UIColor(cgColor: self)
    }
}
