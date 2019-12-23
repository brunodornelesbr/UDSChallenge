//
//  RulingCreationViewModel.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 23/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class RulingCreationViewModel: BaseViewModel {
var title = BehaviorRelay<String>(value: "")
var author = BehaviorRelay<String>(value: "")
var description = BehaviorRelay<String>(value: "")
var details = BehaviorRelay<String>(value: "Detalhes :")
var finishAvailable = BehaviorRelay<Bool>(value: false)
var successAdding = BehaviorRelay<Bool>(value: false)
var bag = DisposeBag()
var userManager = UserManager()
    override init(router: Router) {
        super.init(router: router)
        
    Observable.of(title.asObservable(),author.asObservable(),description.asObservable(),details.asObservable()).merge().subscribe(onNext : {[weak self] _ in
            guard self?.title.value != "" && self?.author.value != "" && self?.description.value != ""  && self?.details.value != "" else {
                self?.finishAvailable.accept(false)
                return}
            self?.finishAvailable.accept(true)
        }).disposed(by: bag)
        
        author.accept(userManager.getUserName())
    }
    
    func save() {
        guard self.title.value != "" && self.author.value != "" && self.description.value != ""  && self.details.value != "" else {
            showError(error: "Não foi possivel salvar")
        return}
        let ruling = Ruling()
        ruling.author = author.value
        ruling.description = description.value
        ruling.details = details.value
        ruling.title = title.value
        userManager.saveRuling(ruling: ruling)
        successAdding.accept(true)
    }
    
    func didAdd() {
        title.accept("")
        description.accept("")
        details.accept("Detalhes :")
    }
}
