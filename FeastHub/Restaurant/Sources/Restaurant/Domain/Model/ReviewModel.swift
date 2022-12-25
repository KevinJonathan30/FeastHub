//
//  ReviewModel.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import Foundation

public struct ReviewModel: Equatable, Identifiable {
    public var id: UUID = UUID()
    public var name: String = ""
    public var review: String = ""
    public var date: String = ""
}
