//
//  RulingVisualizerViewController.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 23/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class RulingVisualizerViewController: UIViewController {
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var model : RulingVisualizerViewModel!
    var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        model.loadData()
    }
    
    func setupRx() {
        segmentController.rx.selectedSegmentIndex.subscribe(onNext : {[weak self] value in
            self?.model.didSelectSegmentControlIndex(index: value)
        }).disposed(by:bag)
        tableView.delegate = self
        model.availableRuling.bind(to: tableView.rx.items(cellIdentifier: "rulingcell", cellType: RulingTableViewCell.self)){
            (row, element, cell) in
            cell.authorLabel.text = element.author
            cell.detailsView.text = element.details
            cell.descriptionLabel.text = element.description
            cell.titleLabel.text = element.title
            cell.finishButton.rx.tap.subscribe(onNext : {
                _ in
                self.model.askedToCloseOrReopenRuling()
            })
            let titleString = self.model.filterType.value == .open ? "Finalizar" : "Reabrir"
            cell.finishButton.setTitle(titleString, for: .normal)
            
        }.disposed(by: bag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RulingVisualizerViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == model.selectedIndex {
            return 300
        } else {
        return 65
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oldIndex = model.selectedIndex
        guard oldIndex != indexPath.row else{
            model.selectedIndex = -1
            tableView.reloadRows(at: [IndexPath(row: oldIndex, section: 0)], with: .fade)
            return
        }
        model.didSelectIndexPath(index: indexPath.row)
        
        var pathsToReload = [indexPath]
        if oldIndex >= 0{
            pathsToReload.append(IndexPath(row: oldIndex, section: 0))
        }
        
        tableView.reloadRows(at: pathsToReload, with: .fade)
    }
}

