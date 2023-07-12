//
//  ReactiveLoggingService.swift
//  ReactiveProgrammingLab
//
//  Created by kiran on 05/07/23.
//

import Foundation
import OSLog
import RxSwift

class ReactiveLoggingService {
    
    let defaultLog = Logger()
    
    let disposeBag = DisposeBag()
    
    func log(_ content: String) {
        defaultLog.debug("rx: \(content)")
    }
    
    func observeChanges(_ subject: PublishSubject<UserStatus>) {
        subject.subscribe { event in
            guard let userStatus = event.element else { return }
            self.log(userStatus.rawValue)
        }
        .disposed(by: disposeBag)
    }
    
    func observeChangesAny(_ subject: Observable<UserStatus>) {
        subject.subscribe { event in
            guard let userStatus = event.element else { return }
            self.log(userStatus.rawValue)
        }
        .disposed(by: disposeBag)
    }
}


