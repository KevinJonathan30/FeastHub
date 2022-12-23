//
//  DataSource.swift
//  
//
//  Created by Kevin Jonathan on 23/12/22.
//

import Combine
 
public protocol DataSource {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
