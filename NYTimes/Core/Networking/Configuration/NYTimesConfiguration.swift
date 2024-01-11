//
//  NYTimesConfiguration.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import core_architecture
import Network
import Dependencies

public struct NYTimesConfiguration {
    @Dependency(\.registerar) private var networkRegisterar
    public init() {}
    func config(name: String, endpoint: NYTimesEndpoint, responseModel: DataModelProtocol.Type, method: HTTPMethod = .get, contentType: ContentType = .queryParam, cachePolicy: NetworkCachePolicy = .cacheEveryTime, headers: [String: String] = [:]) {
        do {
            try self.networkRegisterar.networkRegister(name: name, host: NYTimesHost(), endpoint: endpoint, method: method, contentType: contentType, responseType: responseModel, cachePolicy: cachePolicy, headers: headers)
        }
        catch let err {
            fatalError("NYTimesConfiguration error \(err)")
        }
    }
}
