//
//  ReviewModel.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import Foundation

struct ReviewModel: Equatable, Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var review: String = ""
    var date: String = ""
}
