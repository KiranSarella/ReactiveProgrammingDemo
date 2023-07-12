//
//  DashboardStateBroadcast.swift
//  ReactiveProgrammingLab
//
//  Created by kiran on 05/07/23.
//

import Foundation
import SwiftUI
import RxSwift
import Combine

protocol UserStatusChangeDelegate: AnyObject {
    
    func didChangeUserStatus(_ newValue: UserStatus)
}

class DashboardStateBroadcast: ObservableObject {
    
    // way 1 - with delegate
    weak var userStatusChangeDelegate: UserStatusChangeDelegate? = nil
    
    // way 2 - with RxSwift
    var userStatusChangeObserver = PublishSubject<UserStatus>()
    
    // way 3 - with Combine
    var userStatusChangeSubject = PassthroughSubject<UserStatus, Never>()
    
    func didChangeUserStatus(_ userStatus: UserStatus) {
        // way 1
        userStatusChangeDelegate?.didChangeUserStatus(userStatus)
        
        // way 2
        userStatusChangeObserver.onNext(userStatus)
        
        // way 3
        userStatusChangeSubject.send(userStatus)
    }
    
    
    
    
    
    // fetch data
    @Published var fetchingData = false
    var disposeBag = DisposeBag()
    @Published var token: String? = nil
    
    func fetchData() {
        fetchingData = true
        fetchDataFromService()
            .subscribe(onNext: { token in
                self.token = token
            }, onCompleted: {
                self.fetchingData = false
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchDataFromService() -> RxSwift.Observable<String> {
        
        let data = "ASDFASDF234SDF234$"
        return Observable.just(data).delay(.seconds(5), scheduler: MainScheduler.instance)
    }
}
