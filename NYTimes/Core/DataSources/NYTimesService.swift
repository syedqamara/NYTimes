//
//  NYTimesService.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import Combine
import core_architecture

protocol NYTimesDataSourcing: DataSourcing {
    func mostViewedArticles(days: Int) async throws -> [NYTArticle]
    func mostViewedArticlesPublisher(days: Int) -> Future<[NYTArticle], Error>
}

