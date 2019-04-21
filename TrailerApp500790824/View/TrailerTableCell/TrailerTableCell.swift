//
//  TrailerTableCell.swift
//  TrailerApp500790824
//
//  Created by Dennis Pagarusha on 12/04/2019.
//  Copyright © 2019 Dennis Pagarusha. All rights reserved.
//

import Foundation
import UIKit

class TrailerTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()       
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        posterImageView.image = nil
        descriptionTextView.text = nil
    }
}
