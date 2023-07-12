//
//  SettingsView.swift
//  ReactiveProgrammingLab
//
//  Created by kiran on 05/07/23.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var userStatus: UserStatus
    
    var body: some View {
        Form {
            Picker("User Status", selection: $userStatus) {
                ForEach(UserStatus.allCases) { item in
                    Text(item.rawValue.capitalized)
                }
            }
        }
    }
}

#Preview {
    SettingsView(userStatus: Binding.constant(UserStatus.available))
}
