//
//  ReviewResponse.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation

public struct ReviewResponse: Decodable {
    let name: String?
    let review: String?
    let date: String?
}
