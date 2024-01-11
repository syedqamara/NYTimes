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
    public func mostViewedArticles(days: Int) async throws -> [NYTArticle] {
        let response = try await networking.send(to: NYTimesEndpoint.mostViewed(days), with: nil, type: NYTimesDM.self)
        guard let result = response.results else {
            throw SystemError.custom(NSError(domain: "com.nytimes.most-popular.data-source.no-results", code: 1))
        }
        return result
    }
    // Combine Wrapper for service
    func mostViewedArticlesPublisher(days: Int) -> Future<[NYTArticle], Error> {
        return Future { promise in
            Task {
                do {
                    let articles = try await self.mostViewedArticles(days: days)
                    promise(.success(articles))
                }
                catch let error {
                    promise(.failure(error))
                }
            }
        }
    }
}
