//
//  NetworkMonitor.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private var status: NWPath.Status = .satisfied
    private let queue = DispatchQueue(label: "NetworkMonitor")

    private init() {
        startMonitoring()
    }

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }

    func isConnected() -> Bool {
        return status == .satisfied
    }
}
