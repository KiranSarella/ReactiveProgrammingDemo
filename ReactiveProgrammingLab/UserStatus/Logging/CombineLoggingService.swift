//
//  CombineLoggingService.swift
//  ReactiveProgrammingLab
//
//  Created by kiran on 11/07/23.
//

import Foundation
import OSLog
import Combine


class CombineLoggingService {
    
    let defaultLog = Logger()
    
//    var cancellable: AnyCancellable?
//    var cancellable2: AnyCancellable?
    
    var cancellable = Set<AnyCancellable>()
    
    func log(_ content: String) {
        defaultLog.debug("combine: \(content)")
    }
    
    func observeChanges(_ subject: PassthroughSubject<UserStatus, Never>) {
//        cancellable = subject.sink { userStatus in
//            self.log(userStatus.rawValue)
//        }
        
        subject.sink { userStatus in
            self.log(userStatus.rawValue)
        }.store(in: &cancellable)
    }
    
    func observeChangesAny(_ subject: AnyPublisher<UserStatus, Never>) {
        
//        cancellable2 = subject.sink { userStatus in
//            self.log(userStatus.rawValue)
//        }
        
        subject.sink { userStatus in
            self.log(userStatus.rawValue)
        }.store(in: &cancellable)
        
        
    }
    
}



