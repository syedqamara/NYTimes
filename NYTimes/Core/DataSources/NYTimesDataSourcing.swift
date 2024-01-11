//
//  NYTimesDataSourcing.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import Combine
import core_architecture

protocol NYTimesDataSourcing: DataSourcing {
    func mostViewedArticlesPublisher(days: Int) -> Future<[NYTArticle], Error>
}

