//
//  MainView.swift
//  ReactiveProgrammingLab
//
//  Created by kiran on 05/07/23.
//

import SwiftUI

struct MainView: View {
    
    @State private var logger = LoggingService()
//    @State private var rxlogger = ReactiveLoggingService()
    
    var body: some View {
        DashboardView()
            .environment(logger)
//            .environment(rxlogger)
    }
}

#Preview {
    MainView()
}
