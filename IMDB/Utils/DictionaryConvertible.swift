//
//  DictionaryConvertible.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Foundation

protocol DictionaryConvertible {}

extension DictionaryConvertible {
    /// Converts the conformance object to dictionary
    /// - Returns: Return dictionary representation of object
    func toDict() -> [String:Any] {
        var dict = [String: Any]()
        let otherSelf = Mirror (reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                if let childValue = child.value as? DictionaryConvertible {
                    dict[key] = childValue.toDict()
                } else {
                    dict[key] = child.value
                }
            }
        }
    return dict
    }
}
