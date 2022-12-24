//
//  CustomErrorExtension.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation

public enum URLError: LocalizedError {
    case invalidResponse
    case addressUnreachable(URL)
    
    public var errorDescription: String? {
        switch self {
        case .invalidResponse: return "server_error".localized()
        case .addressUnreachable(_): return "url_unreachable".localized()
        }
    }
}

public enum DatabaseError: LocalizedError {
    case invalidInstance
    case requestFailed
    
    public var errorDescription: String? {
        switch self {
        case .invalidInstance: return "database_error".localized()
        case .requestFailed: return "request_failed".localized()
        }
    }
}
