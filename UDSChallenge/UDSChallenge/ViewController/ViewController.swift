//
//  ViewController.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 22/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


extension UIViewController {
    func bindToShowError(viewModel : BaseViewModel, bag : DisposeBag) {
        viewModel.errorToBeShow.subscribe(onNext : {[weak self] value in
            guard let value = value else {return}
            let alert = UIAlertController(title: "Informação", message: value,preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                   }))
            self?.present(alert, animated: true, completion: nil)

            }).disposed(by: bag)
    }
}
