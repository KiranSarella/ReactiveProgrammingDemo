//
//  DashboardView.swift
//  ReactiveProgrammingLab
//
//  Created by kiran on 05/07/23.
//

import SwiftUI



struct DashboardView: View {
    
    @State var state = DashboardState()
    @State private var isPresented = false
    
    @StateObject private var stateBroadcast = DashboardStateBroadcast()
    
    var rxlogger = ReactiveLoggingService()
    var combineLogger = CombineLoggingService()
    
    @Environment(LoggingService.self) private var logger
//    @Environment(ReactiveLoggingService.self) private var rxlogger
    
    var body: some View {
        
        NavigationStack {
            VStack {
//                Text("Dashboard")
//                    .foregroundStyle(.gray)
                
                Button {
                    stateBroadcast.fetchData()
                } label: {
                    Text("Fetch token")
                }
                .padding()
                .disabled(stateBroadcast.fetchingData ? true : false)
                
                if stateBroadcast.fetchingData {
                    ProgressView()
                } else if stateBroadcast.token != nil {
                    Text(stateBroadcast.token!)
                }
            }
            .onAppear(perform: {
                // register events
                // way 1
                stateBroadcast.userStatusChangeDelegate = logger
                // way 2
                rxlogger.observeChanges(stateBroadcast.userStatusChangeObserver)
                rxlogger.observeChangesAny(stateBroadcast.userStatusChangeObserver.asObservable())
                // way 3
                combineLogger.observeChanges(stateBroadcast.userStatusChangeSubject)
                combineLogger.observeChangesAny(stateBroadcast.userStatusChangeSubject.eraseToAnyPublisher())
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isPresented = true
                    }, label: {
                        Image(systemName: "gearshape")
                    })
                }
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Circle().fill(state.userState.color)
                        Text(state.userState.rawValue.capitalized)
                            .fixedSize()
                    }
                }
            })
        }
        .sheet(isPresented: $isPresented, content: {
            SettingsView(userStatus: $state.userState)
        })
        .onChange(of: state.userState) { oldValue, newValue in
            stateBroadcast.didChangeUserStatus(newValue)
        }
    }
}

#Preview {
    DashboardView()
        .environment(LoggingService())
}
