//
//  StringExtension.swift
//  ContactApp
//
//  Created by Pawan Kumar on 18/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var firstCharacter: Character {
        if self.count <= 0 {
            return Character(" ")
        }
        return self[self.index(self.startIndex, offsetBy: 0)]
    }
    
    var lastCharacter: Character {
        if self.count <= 0 {
            return Character(" ")
        }
        return self[self.index(self.endIndex, offsetBy: -1)]
    }
    
    var firstWord: String {
        if self.count <= 0 {
            return ""
        }
        return String(self.split(separator: " ").first ?? Substring(""))
    }
    
    var lastWord: String {
        if self.count <= 0 {
            return ""
        }
        return String(self.split(separator: " ").last ?? Substring(""))
    }
    
    var isPhoneNumber: Bool {
        return self.count >= 10
    }
    
    var isEmail: Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    // EZSE: remove Multiple Spaces And New Lines
    var removeAllWhiteSpacesAndNewLines: String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    var removeLeadingTrailingWhitespaces: String {
        let spaceSet = CharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: spaceSet)
    }
    
    // Removing All WhiteSpaces
    var removeAllWhitespaces: String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// EZSE: Converts String to URL
    var toUrl: URL? {
        if self.hasPrefix("https://") || self.hasPrefix("http://") {
            return URL(string: self)
        } else {
            return URL(fileURLWithPath: self)
        }
    }
    
    var toBool: Bool {
        switch self.lowercased() {
        case "1", "true", "yes", "ok":
            return true
        default:
            return false
        }
    }
    
    /// EZSE: Converts String to Int
    var toInt: Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    var toInt32: Int32? {
        if let int = self.toInt {
            return Int32(int)
        }
        return nil
    }
    
    var toInt64: Int64? {
        if let int = self.toInt {
            return Int64(int)
        }
        return nil
    }
    
    /// EZSE: Converts String to Double
    var toDouble: Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    /// EZSE: Converts String to Float
    var toFloat: Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    var toFloat32: Float32? {
        if let float = self.toFloat {
            return Float32(float)
        }
        return nil
    }
    
    var toFloat64: Float64? {
        if let float = self.toFloat {
            return Float64(float)
        }
        return nil
    }
    
    var toCGFloat: CGFloat? {
        if let float = self.toFloat {
            return CGFloat(float)
        }
        return nil
    }
    
    /// EZSE: Capitalizes first character of String
    public mutating func capitalizeFirst() {
        guard self.count > 0 else { return }
        self.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).capitalized)
    }
    
    /// EZSE: Capitalizes first character of String, returns a new string
    public func capitalizedFirst() -> String {
        guard self.count > 0 else { return self }
        var result = self
        
        result.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).capitalized)
        return result
    }
}
