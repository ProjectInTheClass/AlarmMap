//
//  MetroTableViewCell.swift
//  DynamicTableViewPractice
//
//  Created by 김요환 on 2020/04/24.
//  Copyright © 2020 Kloong. All rights reserved.
//

import UIKit

class MetroCell: UITableViewCell {
    
    /* Top line */

    @IBOutlet var lineLabel: UILabel!
    
    @IBOutlet var stationNameLabel: UILabel!
    
    @IBOutlet var directionLabel: UILabel!
    
    /* Trains */
    
    @IBOutlet var firstTrainStackView: UIView!
    
    @IBOutlet var secondTrainStackView: UIView!
    
    @IBOutlet var thirdTrainStackView: UIView!
    
    @IBOutlet var fourthTrainStackView: UIView!
    
    var stacViewList: [UIView] = []
    
    
    /* Labels in first stackview */
    
    @IBOutlet var timeRemainingFirstTrainLabel: UILabel!
    
    @IBOutlet var currentStationFirstTrainLabel: UILabel!
    
    @IBOutlet var terminalStationFirstTrainLabel: UILabel!
    
    /* Labels in second stackview */
    
    @IBOutlet var timeRemainingSecondTrainLabel: UILabel!
    
    @IBOutlet var currentStationSecondTrainLabel: UILabel!
    
    @IBOutlet var terminalStationSecondTrainLabel: UILabel!
    
    /* Labels in third stackview */
    
    @IBOutlet var timeRemainingThirdTrainLabel: UILabel!
    
    @IBOutlet var currentStationThirdTrainLabel: UILabel!
    
    @IBOutlet var terminalStationThirdTrainLabel: UILabel!
    
    /* Labels in fourth stackview */
    
    @IBOutlet var timeRemainingFourthTrainLabel: UILabel!
    
    @IBOutlet var currentStationFourthTrainLabel: UILabel!
    
    @IBOutlet var terminalStationFourthTrainLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stacViewList = [firstTrainStackView, secondTrainStackView, thirdTrainStackView, fourthTrainStackView]
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
