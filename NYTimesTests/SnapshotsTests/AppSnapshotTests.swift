//
//  AppSnapshots.swift
//  NYTimesTests
//
//  Created by Apple on 12/01/2024.
//

import Foundation
import XCTest
import Dependencies
import core_architecture
import Combine
import SnapshotTesting
@testable import NYTimes

class AppSnapshots: NYTBaseTests<NYTBaseTests.DataSourceDependency> {
    func testSnapshots() throws {
        setup(
            dataSourceReturn: .mostViewed(.init()),
            imageDataSourceReturn: .image(.init())
        )
        NYTimesAppView_Previews.snapshots.assertSnapshots(as: .image(layout: .device(config: .iPhone13ProMax)))
    }
}

