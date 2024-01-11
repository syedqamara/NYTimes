//
//  NYTImageDataSourceMock.swift
//  NYTimes
//
//  Created by Apple on 12/01/2024.
//

import Foundation
import UIKit
import core_architecture

public final class NYTImageDataSourceMock: Mocking<NYTImageDataSourceMock.Parameters, NYTImageDataSourceMock.Returned> {
    public enum Parameters {
    case url(MockFunctionArgument<String>)
        public var rawValue: String {
            switch self {
            case .url(_):
                return "url"
            }
        }
        
    }
    public enum Returned {
    case image(MockFunctionArgument<Data>)
        public var rawValue: String {
            switch self {
            case .image(_):
                return "image"
            }
        }
    }
}
extension NYTImageDataSourceMock: NYTimesImageDataSourcing {
    public func image(for urlString: String) async throws -> Data {
        // Invoking the recieved Parameter.
        if case .url(let arg) = parameter {
            if let value = arg.argumentLastValue {
                arg.invoked(by: value)
            } else {
                arg.invoked(by: urlString)
            }
        }
        // Returning a custom return
        if case .image(let arg) = returned {
            if let value = arg.argumentLastValue {
                arg.invoked(by: value)
                return value
            }
        }
        return try loadDummyImage()
    }
    
    fileprivate func loadDummyImage() throws -> Data {
        if let png = UIImage(named: "mock_image")?.pngData() {
            return png
        }
        if let jpeg = UIImage(named: "mock_image")?.jpegData(compressionQuality: 1.0) {
            return jpeg
        }
        throw SystemError.custom(NSError(domain: "com.mock.image.notFound", code: 1))
    }
}
