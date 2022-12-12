//
//  ReviewMapper.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 12/12/22.
//

import Foundation

final class ReviewMapper {
    
    // MARK: Response to Model
    
    static func mapReviewResponseListToModelList(
        input reviewResponseList: [ReviewResponse]
    ) -> [ReviewModel] {
        return reviewResponseList.map { result in
            var reviewModel = ReviewModel()
            reviewModel.name = result.name ?? ""
            reviewModel.date = result.date ?? ""
            reviewModel.review = result.review ?? ""
            return reviewModel
        }
    }
}
