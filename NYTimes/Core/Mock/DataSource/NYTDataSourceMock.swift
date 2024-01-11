//
//  NYTimesDataSourceMock.swift
//  NYTimes
//
//  Created by Apple on 12/01/2024.
//

import Foundation
import Combine

final class NYTimesDataSourceMock: Mocking<NYTimesDataSourceMock.Parameter, NYTimesDataSourceMock.Returned> {
    enum Errors: String, Error {
    case noValue, inValidReturnData
    }
    public enum Parameter {
        case days(MockFunctionArgument<Int>)
        public var rawValue: String {
            switch self {
            case .days(_):
                return "days"
            }
        }
    }
    public enum Returned {
        case mostViewed(MockFunctionArgument<Future<[NYTArticle], Error>>)
        
        var rawValue: String {
            switch self {
            case .mostViewed(_):
                return "mostViewed"
            }
        }
    }
}


extension NYTimesDataSourceMock: NYTimesDataSourcing {
    func mostViewedArticlesPublisher(days: Int) -> Future<[NYTArticle], Error> {
        if case .days(let arg) = parameter {
            if let value = arg.argumentLastValue {
                arg.invoked(by: value)
            } else {
                arg.invoked(by: 0)
            }
        }
        if case .mostViewed(let arg)  = returned {
            if let value = arg.argumentLastValue {
                arg.invoked(by: value)
                return value
            }
        }
        return Future { promise in
            promise(.failure(Errors.noValue))
        }
    }
    
}
