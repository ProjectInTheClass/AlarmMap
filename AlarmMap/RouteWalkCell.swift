//
//  RouteWalkCell.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/21.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class RouteWalkCell: UITableViewCell {
    
    @IBOutlet var routeDetailLeftView: RouteDetailLeftView!
    
    @IBOutlet var locationSymbolImageView: UIImageView!
    
    @IBOutlet var walkingSymbolImageView: UIImageView!
    
    @IBOutlet var locationNameLabel: UILabel!
    
    @IBOutlet var locationInfoLabel: UILabel!
    
    @IBOutlet var walkTimeAndDistLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
