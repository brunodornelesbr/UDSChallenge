//
//  RulingVisualizerViewModel.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 23/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum FilterType : Int {
    case open = 0
    case closed = 1
}
class RulingVisualizerViewModel: BaseViewModel {
    
    var filterType = BehaviorRelay<FilterType>(value: FilterType.open)
    var availableRuling = BehaviorRelay<[Ruling]>(value: [])
    var rulings = [Ruling]()
    var userManager = UserManager()
    var bag = DisposeBag()
    var selectedIndex = -1
    override init(router: Router) {
        super.init(router: router)
        
      loadData()
    }
    
    func loadData() {
        rulings = userManager.getRulingList()
              
              filterType.asObservable().subscribe(onNext : {[weak self] value in
                  self?.selectedIndex = -1
                  let filteredRulings : [Ruling] = self?.rulings.filter{ rulingObject in
                      if FilterType(rawValue:rulingObject.open) == value{
                          return true
                      } else {return false}
                      } ?? []
                  self?.availableRuling.accept(filteredRulings)
                  
              }).disposed(by: bag)
    }
    
    func askedToCloseOrReopenRuling() {
        guard selectedIndex >= 0 else {return}
        var rulingBeingShow = availableRuling.value[selectedIndex]
        
        
        guard let indexOfRuling = rulings.firstIndex(of: rulingBeingShow) else {return}
        rulings[indexOfRuling].open = (filterType.value == .open) ? 1 : 0
        
        userManager.updateRulings(rulings : rulings)
        loadData()
        
    }
    
    func didSelectSegmentControlIndex(index: Int) {
       
        guard let filter = FilterType(rawValue: index) else {return}
        filterType.accept(filter)
    }
    
    func didSelectIndexPath(index : Int) {
        selectedIndex = index
    }
}
