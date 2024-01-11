//
//  NYTimesImageService.swift
//  NYTimes
//
//  Created by Apple on 11/01/2024.
//

import Foundation
import core_architecture

protocol NYTimesImageDataSourcing: DataSourcing {
    func image(for urlString: String) async throws -> Data
}
