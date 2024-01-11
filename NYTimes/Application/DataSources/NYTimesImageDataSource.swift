//
//  NYTimesImageDataSource.swift
//  NYTimes
//
//  Created by Apple on 11/01/2024.
//

import Foundation
import core_architecture

class NYTimesImageDataSource: NYTimesImageDataSourcing {
    fileprivate let fileService = NYTimesFileService()
    internal var maxRequest: Int = 10
    private var __requesting__: [String: String] = [:]
    private let requestingQueue: DispatchQueue = DispatchQueue(label: "com.image.request.checker", qos: .background)
    private var requesting: [String: String] {
        get {
            requestingQueue.sync {
                return __requesting__
            }
        }
        set {
            requestingQueue.sync(flags: .barrier) {
                __requesting__ = newValue
            }
        }
    }
    func image(for urlString: String) async throws -> Data {
        guard urlString.isNotEmpty else { throw SystemError.network(.invalidURL) }
        @CachedPermanent<String>(key: urlString) var localPath
        do {
            if let localPath {
                return try fileService.load(fileName: .png(localPath))
            } else if Internet.shared.isAvailable() {
                requesting[urlString] = urlString
                guard let url = URL(string: urlString) else { throw SystemError.network(.invalidURL) }
                let request = URLRequest(url: url)
                let response = try await URLSession.shared.data(for: request)
                guard let httpResponse = response.1 as? HTTPURLResponse, httpResponse.statusCode >= 200, httpResponse.statusCode < 204 else {
                    requesting[urlString] = nil
                    throw SystemError.network(.unauthorized)
                }
                let data = response.0
                let newFileName = UUID().uuidString
                _localPath.wrappedValue = newFileName
                fileService.save(fileName: .png(newFileName), data: data)
                requesting[urlString] = nil
                return data
            }
            throw SystemError.network(.noInternetConnection)
        }
        catch let err {
            throw err
        }
    }
    
    
}

private class NYTimesFileService {
    private let queue: DispatchQueue = .init(label: "com.cache.file.queue", qos: .background)
    func load(fileName: AssetsEnpoint) throws -> Data {
        try queue.sync {
            let cacheDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let url = cacheDirectory.appendingPathComponent(fileName.pointing)
            
            @Cached<Data>(endpoint: fileName) var imageData
            if let imageData {
                return imageData
            }
            return try Data(contentsOf: url)
        }
    }
    func save(fileName: AssetsEnpoint, data: Data?) {
        queue.sync(flags: .barrier) {
            do {
                @Cached<Data>(endpoint: fileName) var imageData
                let cacheDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let url = cacheDirectory.appendingPathComponent(fileName.pointing)
                imageData = data
                if let data = data {
                    if FileManager.default.fileExists(atPath: url.path) {
                        try data.write(to: url, options: .atomic)
                    } else {
                        try data.write(to: url, options: .atomic)
                    }
                } else {
                    if FileManager.default.fileExists(atPath: url.path) {
                        // Rule 1: Remove the existing file if data is nil
                        try FileManager.default.removeItem(at: url)
                    } else {
                        print("No file exists at: \(url)")
                    }
                }
            } catch {
                print("Error getting cache directory: \(error.localizedDescription)")
            }
        }
    }

}
