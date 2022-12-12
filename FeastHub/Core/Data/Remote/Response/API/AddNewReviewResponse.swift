//
//  AddNewReviewResponse.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation

struct AddNewReviewResponse: Decodable {
    let error: Bool?
    let message: String?
    let customerReviews: [ReviewResponse]?
}
