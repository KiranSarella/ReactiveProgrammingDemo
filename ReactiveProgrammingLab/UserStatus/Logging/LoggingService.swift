//
//  Logger.swift
//  ReactiveProgrammingLab
//
//  Created by kiran on 05/07/23.
//


import Foundation
import SwiftUI
import OSLog

@Observable
class LoggingService {
    
    let defaultLog = Logger()
    
    func log(_ content: String) {
        defaultLog.debug("delegate: \(content)")
    }
}

extension LoggingService: UserStatusChangeDelegate {
    func didChangeUserStatus(_ newValue: UserStatus) {
        log(newValue.rawValue)
    }
}
