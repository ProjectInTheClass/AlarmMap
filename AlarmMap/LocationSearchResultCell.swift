//
//  LocationSearchResultCell.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/11.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class LocationSearchResultCell: UITableViewCell {

    @IBOutlet var locationNameLabel: UILabel!
    
    @IBOutlet var locationInfoLabel: UILabel!
    
    var cellIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
