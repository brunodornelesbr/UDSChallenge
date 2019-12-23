//
//  RulingTableViewCell.swift
//  UDSChallenge
//
//  Created by Bruno Dorneles on 23/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit

class RulingTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var detailsView: UITextView!
    @IBOutlet weak var finishButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailsView.layer.cornerRadius = 5
        detailsView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        detailsView.layer.borderWidth = 0.7
        detailsView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
       // super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
