//
//  TableViewCell.swift
//  NYU-Voice
//
//  Created by Liam Wang on 11/29/17.
//  Copyright © 2017 HaiyangWang. All rights reserved.
//

import UIKit
import AVFoundation

protocol audioCellDelegate {
    func getTheURL()
}

class TableViewCell: UITableViewCell, AVAudioPlayerDelegate {

    var soundPlayer : AVAudioPlayer!
    var uniqueKey : Int!
    var delegate:audioCellDelegate?
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var audioTitle: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func playSound(_ sender: Any) {
        
        preparePlayer()
    }
    
    func preparePlayer() {
        //soundPlayer = AVAudioPlayer(contentsOf: delegate?.getTheURL())
        
    }
    
    @IBAction func stopPlaying(_ sender: Any) {
    }
    
}
