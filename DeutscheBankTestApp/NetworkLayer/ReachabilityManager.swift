//
//  ReachabilityManager.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 02.07.2023.
//

import Alamofire

protocol ReachabilityManagerProtocol {
    var isReachable: Bool { get }
    func startNetworkReachabilityObserver()
}

final class ReachabilityManager: ReachabilityManagerProtocol {
    
    private let reachabilityManager = NetworkReachabilityManager()
    
    var isReachable: Bool {
        return self.reachabilityManager?.isReachable ?? false
    }

    func startNetworkReachabilityObserver() {
        
        self.reachabilityManager?.startListening(onUpdatePerforming: { status in
            
            switch status {
            case .notReachable:
                print("The network is not reachable")
            case .unknown :
                print("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
            case .reachable(.cellular):
                print("The network is reachable over the Cellular connection")
            }
        })
    }
}
