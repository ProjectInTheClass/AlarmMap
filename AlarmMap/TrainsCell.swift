//
//  TrainsCell.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/23.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class TrainsCell: UITableViewCell {

    
    @IBOutlet var firstTrainView: UIView!
    
    @IBOutlet var secondTrainView: UIView!
    
    @IBOutlet var thirdTrainView: UIView!

    //first train
    @IBOutlet var firstTrainRemainingTimeLabel: UILabel!
    
    @IBOutlet var firstTrainCurrentStationLabel: UILabel!
    
    @IBOutlet var firstTrainTerminalStationLabel: UILabel!
    
    //second train
    @IBOutlet var secondTrainRemainingTimeLabel: UILabel!
    
    @IBOutlet var secondTrainCurrentStationLabel: UILabel!
    
    @IBOutlet var secondTrainTerminalStationLabel: UILabel!
    
    //third train
    @IBOutlet var thirdTrainRemainingTimeLabel: UILabel!
    
    @IBOutlet var thirdTrainCurrentStationLabel: UILabel!
    
    @IBOutlet var thirdTrainTerminalStationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
