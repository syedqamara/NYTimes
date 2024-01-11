//
//  NYTimesDataSources.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import Network
import Dependencies
import core_architecture
import Foundation
import Combine

public class NYTimesDataSources: NYTimesDataSourcing {
    
    @Dependency(\.defaultNetwork) var networking
    public init() {}
    // Combine Wrapper for service
    func mostViewedArticlesPublisher(days: Int) -> Future<[NYTArticle], Error> {
        return Future {
            [networking]
            promise in
            Task {
                do {
                    let response = try await networking.send(to: NYTimesEndpoint.mostViewed(days), with: nil, type: NYTimesDM.self)
                    if let results = response.results {
                        promise(.success(results))
                    }
                    else {
                        promise(.failure(SystemError.custom(NSError(domain: "com.dataSource.noResults", code: -100))))
                    }
                }
                catch let error {
                    promise(.failure(error))
                }
            }
        }
    }
}
