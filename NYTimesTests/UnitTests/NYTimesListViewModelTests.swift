//
//  NYTimesListViewModelTests.swift
//  NYTimesTests
//
//  Created by Apple on 12/01/2024.
//

import Foundation
import XCTest
import Dependencies
import core_architecture
import Combine
@testable import NYTimes

final class NYTimesListViewModelTests: NYTBaseTests<NYTBaseTests.DataSourceDependency> {

    @Dependency(\.viewFactory) var viewFactory
    
    fileprivate var cancellable: AnyCancellable?
    
    var viewModel: NYTListViewModel!
    
    func testSingleArticleInTheList() throws {
        let expectation = XCTestExpectation(description: "Expect \(self.classForCoder) functionality")
        viewModel = NYTListViewModel(isLoading: false, error: nil, articles: [])
        
        let future = Future<[NYTArticle], Error> { promise in
            promise(.success([.preview]))
        }
        setup(
            dataSourceReturn: .mostViewed(.init(argumentLastValue: future)),
            imageDataSourceReturn: .image(.init())
        )
        
        guard let dataSource = self.dependency?.dataSource else {
            expectation.fulfill()
            XCTAssert(false, "No Mock Data Source or Image Data Source found")
            return
        }
        viewModel.onAppear()
        // Checking the parameter of the DataSource method `mostViewArticles(days:)`.
        if case .days(let arg) = dataSource.parameter {
            XCTAssert(arg.isArgumentRecieved, "Number of Days is not recieved")
            if let value = arg.argumentLastValue {
                XCTAssert(value == 1, "Number of Days is equal to test data")
            }
        }
        
        // Checking the returned articles
        if case .mostViewed(let arg) = dataSource.returned {
            XCTAssert(arg.isArgumentRecieved, "MostView article is not returned")
            if let value = arg.argumentLastValue {
                cancellable = value
                    .receive(on: RunLoop.main)
                    .sink { _ in
                        
                    } receiveValue: { articles in
                        XCTAssert(articles.count == 1, "Returned more than 1 article")
                        if let article = articles.first {
                            XCTAssert(article.id == NYTArticle.preview.id, "Article doesn't match with Test Data")
                            expectation.fulfill()
                        }
                    }
            }
        }
        
        
    }
    
    fileprivate var testError: NSError { NSError(domain: "com.nytimes.listViewModel.testError", code: 1) }
    
    func testErrorArticleInTheList() throws {
        let expectation = XCTestExpectation(description: "Expect \(self.classForCoder) functionality")
        viewModel = NYTListViewModel(isLoading: false, error: nil, articles: [])
        
        let future = Future<[NYTArticle], Error> { promise in
            promise(.failure(self.testError))
        }
        setup(
            dataSourceReturn: .mostViewed(.init(argumentLastValue: future)),
            imageDataSourceReturn: .image(.init())
        )
        
        guard let dataSource = self.dependency?.dataSource else {
            expectation.fulfill()
            XCTAssert(false, "No Mock Data Source or Image Data Source found")
            return
        }
        viewModel.onAppear()
        // Checking the parameter of the DataSource method `mostViewArticles(days:)`.
        if case .days(let arg) = dataSource.parameter {
            XCTAssert(arg.isArgumentRecieved, "Number of Days is not recieved")
            if let value = arg.argumentLastValue {
                XCTAssert(value == 1, "Number of Days is equal to test data")
            }
        }
        
        // Checking the returned articles
        if case .mostViewed(let arg) = dataSource.returned {
            XCTAssert(arg.isArgumentRecieved, "MostView article is not returned")
            if let value = arg.argumentLastValue {
                cancellable = value
                    .receive(on: RunLoop.main)
                    .sink { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            XCTAssert((error as NSError) == self.testError, "Error is not test error")
                            expectation.fulfill()
                            break
                        }
                    } receiveValue: { articles in
                        
                    }
            }
        }
        
        
        wait(for: [expectation], timeout: 5)
    }

}
