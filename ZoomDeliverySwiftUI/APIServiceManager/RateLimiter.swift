//
//  RateLimiter.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 30/07/26.
//

import Foundation

/// A thread-safe Swift Actor that limits the frequency of outgoing API requests.
actor RateLimiter {
    static let shared = RateLimiter(maxRequests: 10, perInterval: 1.0)
    
    private var maxRequests: Int
    private var timeInterval: TimeInterval
    private var requestTimestamps: [Date] = []
    
    /// Initializes a RateLimiter instance.
    /// - Parameters:
    ///   - maxRequests: Maximum allowed requests within the given time interval (default: 10).
    ///   - perInterval: The sliding time window in seconds (default: 1.0s).
    init(maxRequests: Int = 10, perInterval: TimeInterval = 1.0) {
        self.maxRequests = maxRequests
        self.timeInterval = perInterval
    }
    
    /// Updates the rate limiter configuration dynamically.
    func configure(maxRequests: Int, perInterval: TimeInterval) {
        self.maxRequests = maxRequests
        self.timeInterval = perInterval
    }
    
    /// Pauses execution if the number of requests in the current time window exceeds `maxRequests`.
    func waitUntilAvailable() async throws {
        while true {
            let now = Date()
            // Clean up request timestamps older than the sliding window interval
            requestTimestamps = requestTimestamps.filter { now.timeIntervalSince($0) < timeInterval }
            
            if requestTimestamps.count < maxRequests {
                requestTimestamps.append(now)
                return
            } else {
                // Calculate wait time until the oldest timestamp falls outside the sliding window
                if let oldest = requestTimestamps.first {
                    let waitTime = timeInterval - now.timeIntervalSince(oldest)
                    if waitTime > 0 {
                        let nanoseconds = UInt64(waitTime * 1_000_000_000)
                        try await Task.sleep(nanoseconds: nanoseconds)
                    }
                }
            }
        }
    }
    
    /// Resets all tracked request timestamps.
    func reset() {
        requestTimestamps.removeAll()
    }
}
