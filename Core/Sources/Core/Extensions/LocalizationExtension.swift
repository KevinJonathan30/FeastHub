//
//  File.swift
//  
//
//  Created by Kevin Jonathan on 24/12/22.
//

import Foundation

extension String {
    public func localized(identifier: String = "am.dx.kevinjonathan.FeastHub") -> String {
        let bundle = Bundle(identifier: identifier) ?? .main
        return bundle.localizedString(forKey: self, value: nil, table: nil)
    }
}
