//
//  LiveTableViewCell.swift
//  YKLiveStream
//
//  Created by Dwysen on 16/10/17.
//  Copyright © 2016年 Dwysen. All rights reserved.
//

import UIKit

class LiveTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPor: UIImageView!
    
    @IBOutlet weak var lableNick: UILabel!
    
    @IBOutlet weak var labelAddr: UILabel!
    
    @IBOutlet weak var labelViewNumber: UILabel!
    @IBOutlet weak var imgBigPor: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
  
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

          }

}
