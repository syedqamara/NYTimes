//
//  Internet.swift
//  NYTimes
//
//  Created by Apple on 11/01/2024.
//

import Foundation
import SystemConfiguration

class Internet {
    static let shared = Internet()

    private var reachability: SCNetworkReachability?
    private var reachabilityQueue = DispatchQueue(label: "com.nytimes.networkReachability")

    private init() {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)

        reachability = SCNetworkReachabilityCreateWithAddress(nil, &zeroAddress)

        if let reachability = reachability {
            SCNetworkReachabilitySetDispatchQueue(reachability, reachabilityQueue)
        }
    }

    deinit {
        if let reachability = reachability {
            SCNetworkReachabilitySetDispatchQueue(reachability, nil)
        }
    }

    func isAvailable() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return isReachable && !needsConnection
    }
}
