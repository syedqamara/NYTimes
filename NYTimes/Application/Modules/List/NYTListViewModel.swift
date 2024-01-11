//
//  NYTListViewModel.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import Foundation
import Dependencies
import Combine

public final class NYTListViewModel: NYTListViewModeling {
    @Published public var isLoading: Bool = false
    @Published public var error: String? = nil
    @Published public var articles: [NYTArticleUIM] = []
    
    private var cancellable: AnyCancellable?
    
    @Dependency(\.mostPopular) var mostPopular
    
    public init(isLoading: Bool, error: String?, articles: [NYTArticleUIM]) {
        self.isLoading = isLoading
        self.error = error
        self.articles = articles
    }
    
    public func onAppear() {
        guard !isLoading, articles.isEmpty, error == nil else { return }
        isLoading = true
        cancellable = mostPopular.mostViewedArticlesPublisher(days: 1)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Task completed successfully")
                case .failure(let error):
                    self.error = error.localizedDescription
                    print("Task failed with error: \(error)")
                }
                self.isLoading = false
            } receiveValue: { list in
                self.articles = list.map { .init(dataModel: $0) }
                self.isLoading = false
            }

    }
}
