//
//  BaseViewModel.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 22/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class BaseViewModel {
    var errorToBeShow = BehaviorRelay<String?>(value: nil)
    
    func showError(error : String) {
        errorToBeShow.accept(error)
    }
    
    weak var router : Router?
          init(router : Router) {
              self.router = router
       }
}
