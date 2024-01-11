//
//  Previewer+Snapshots.swift
//  NYTimesTests
//
//  Created by Apple on 12/01/2024.
//

import Foundation
import SnapshotTesting
import SwiftUI
import NYTimes

extension Previewer {
    
    public func assertSnapshots<Format>(
        as snapshotting: Snapshotting<AnyView, Format>,
        named name: String? = nil,
        record recording: Bool = false,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        for configuration in configurations {
            assertSnapshot(
                matching: configure(configuration.state),
                as: snapshotting,
                named: configuration.snapshotName(prefix: name),
                record: recording,
                file: file, testName: testName, line: line
            )
        }
    }
    
    public func assertSnapshots<Format>(
        as strategies: [String: Snapshotting<AnyView, Format>],
        named name: String? = nil,
        record recording: Bool = false,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        for configuration in configurations {
            for (key, strategy) in strategies {
                assertSnapshot(
                    matching: configure(configuration.state),
                    as: strategy,
                    named: configuration.snapshotName(prefix: name) + "-\(key)",
                    record: recording,
                    file: file, testName: testName, line: line
                )
            }
        }
    }
    
    public func assertSnapshots<Format>(
        as strategies: [Snapshotting<AnyView, Format>],
        named name: String? = nil,
        record recording: Bool = false,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        for configuration in configurations {
            for (position, strategy) in strategies.enumerated() {
                assertSnapshot(
                    matching: configure(configuration.state),
                    as: strategy,
                    named: configuration.snapshotName(prefix: name) + "-\(position + 1)",
                    record: recording,
                    file: file, testName: testName, line: line
                )
            }
        }
    }
}

// MARK: - Previewer.assertSnapshots + modify

extension Previewer {
    
    public func assertSnapshots<Modified: View, Format>(
        as snapshotting: Snapshotting<Modified, Format>,
        named name: String? = nil,
        record recording: Bool = false,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line,
        modify: (AnyView) -> Modified
    ) {
        for configuration in configurations {
            assertSnapshot(
                matching: modify(configure(configuration.state)),
                as: snapshotting,
                named: configuration.snapshotName(prefix: name),
                record: recording,
                file: file, testName: testName, line: line
            )
        }
    }
    
    public func assertSnapshots<Modified: View, Format>(
        as strategies: [String: Snapshotting<AnyView, Format>],
        named name: String? = nil,
        record recording: Bool = false,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line,
        modify: (AnyView) -> Modified
    ) {
        for configuration in configurations {
            for (key, strategy) in strategies {
                assertSnapshot(
                    matching: configure(configuration.state),
                    as: strategy,
                    named: configuration.snapshotName(prefix: name) + "-\(key)",
                    record: recording,
                    file: file, testName: testName, line: line
                )
            }
        }
    }
    
    public func assertSnapshots<Modified: View, Format>(
        as strategies: [Snapshotting<Modified, Format>],
        named name: String? = nil,
        record recording: Bool = false,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line,
        modify: (AnyView) -> Modified
    ) {
        for configuration in configurations {
            for (position, strategy) in strategies.enumerated() {
                assertSnapshot(
                    matching: modify(configure(configuration.state)),
                    as: strategy,
                    named: configuration.snapshotName(prefix: name) + "-\(position)",
                    record: recording,
                    file: file, testName: testName, line: line
                )
            }
        }
    }
}

#if os(iOS) || os(tvOS)
// MARK: - UIImage defaults

extension Previewer {
    
    public func assertSnapshots(
        named name: String? = nil,
        record recording: Bool = false,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        assertSnapshots(as: .image, named: name, record: recording, file: file, testName: testName, line: line)
    }
}

// MARK: - Previewer.assertSnapshots + modify

extension Previewer {
    
    public func assertSnapshots<Modified: View>(
        named name: String? = nil,
        record recording: Bool = false,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line,
        modify: (AnyView) -> Modified
    ) {
        assertSnapshots(as: .image, named: name, record: recording, file: file, testName: testName, line: line, modify: modify)
    }
}
#endif

// MARK: Configuration name helper

private extension Previewer.Configuration {
    /// Construct a snapshot name based on the configuration name and an optional prefix.
    func snapshotName(prefix: String?) -> String {
        guard let prefix = prefix else { return name }
        return "\(prefix)-\(name)"
    }
}
