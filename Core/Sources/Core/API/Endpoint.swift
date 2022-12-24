//
//  APICall.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation

public struct API {
    static let baseUrl = "https://restaurant-api.dicoding.dev/"
}

public protocol Endpoint {
    var url: String { get }
}

public enum Endpoints {
    public enum Restaurant: Endpoint {
        case list
        case detail
        case search
        case addReview
        
        public var url: String {
            switch self {
            case .list: return "\(API.baseUrl)list"
            case .detail: return "\(API.baseUrl)detail/"
            case .search: return "\(API.baseUrl)search?q="
            case .addReview: return "\(API.baseUrl)review"
            }
        }
    }
}
