//
//  DashboardState.swift
//  ReactiveProgrammingLab
//
//  Created by kiran on 05/07/23.
//

import SwiftUI


enum UserStatus: String, CaseIterable, Identifiable {
    case available
    case busy
    case offline
    
    var id: Self { self }
    
    var color: Color {
        switch self {
        case .available:
            return .green
        case .busy:
            return .red
        case .offline:
            return .gray
        }
    }
}

@Observable
class DashboardState {
    
    var userState: UserStatus = .available
    
}

