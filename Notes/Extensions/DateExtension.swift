//
//  DateExtension.swift
//  Notes
//
//  Created by Porfirio Diaz on 26/09/23.
//

import Foundation

public extension Date {
    var iso8601String: String{
        Formatter.iso8601withFractionalSeconds.string(from: self)
    }
}
