//
//  photoCell.swift
//  FacebookDemoSwift
//
//  Created by Sherman Leung on 4/16/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class photoCell: UITableViewCell {

  @IBOutlet var photoCaption: UILabel!
  @IBOutlet var photoView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
