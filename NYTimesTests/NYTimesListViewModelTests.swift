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
    
    var view: NYTListView<NYTListViewModel>!
    
    private func setup(dataSourceReturn: NYTimesDataSourceMock.Returned, imageDataSourceReturn: NYTImageDataSourceMock.Returned) {
        guard let dependency else { return }
        let mockVoid = MockFunctionArgument(argumentLastValue: "mock")
        
        dependency.dataSource.returned = dataSourceReturn
        dependency.imageDataSource.returned = imageDataSourceReturn
    }
    
    override func setUp() async throws {
        prepare {
            @Dependency(\.imageSource) var imageSource
            @Dependency(\.mostPopular) var mostPopular
            
            let arg = DataSourceDependency(
                dataSource: mostPopular as! NYTimesDataSourceMock,
                imageDataSource: imageSource as! NYTImageDataSourceMock
            )
            return arg
        }
    }

    func testSingleArticleInTheList() throws {
        view = self.viewFactory.makeView(input: .list(isLoading: false, error: nil, articles: [])) as? NYTListView<NYTListViewModel>
        
        var future = Future<[NYTArticle], Error> { promise in
            promise(.success([.preview]))
        }
        setup(
            dataSourceReturn: .mostViewed(.init(argumentLastValue: future)),
            imageDataSourceReturn: .image(.init())
        )
        
        guard let dataSource = self.dependency?.dataSource, let imageSource = self.dependency?.imageDataSource else {return}
        
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
                        }
                    }
            }
        }
        
        if case .url(let arg) = imageSource.parameter {
            XCTAssert(arg.isArgumentRecieved, "Image URL is recieved to download")
            if let value = arg.argumentLastValue {
                XCTAssert(value == "preview_url", "Image URL doesn't match with test data")
            }
        }
        
        view.viewModel.onAppear()
        
    }
    
    fileprivate var testError: NSError { NSError(domain: "com.nytimes.listViewModel.testError", code: 1) }
    
    func testErrorArticleInTheList() throws {
        view = self.viewFactory.makeView(input: .list(isLoading: false, error: nil, articles: [])) as? NYTListView<NYTListViewModel>
        
        var future = Future<[NYTArticle], Error> { promise in
            promise(.failure(self.testError))
        }
        setup(
            dataSourceReturn: .mostViewed(.init(argumentLastValue: future)),
            imageDataSourceReturn: .image(.init())
        )
        
        guard let dataSource = self.dependency?.dataSource, let imageSource = self.dependency?.imageDataSource else {return}
        
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
                        }
                    }
            }
        }
        
        if case .url(let arg) = imageSource.parameter {
            XCTAssert(arg.isArgumentRecieved, "Image URL is recieved to download")
            if let value = arg.argumentLastValue {
                XCTAssert(value == "preview_url", "Image URL doesn't match with test data")
            }
        }
        
        view.viewModel.onAppear()
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
