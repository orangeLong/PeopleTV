//
//  XLiveCell.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/7/6.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

class XLiveCell: UICollectionViewCell {

    @IBOutlet weak var titleImage: UIImageView!
    
    @IBOutlet weak var peopleImage: UIImageView!
    
    @IBOutlet weak var peopleCount: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var title: UILabel!
    
    private var _liveObj: XLiveObject?
    internal var liveObj: XLiveObject?{
        set(newValue) {
            _liveObj = newValue
            if newValue != nil {
                titleImage.sd_setImageWithURL(NSURL.init(string: newValue!.liveImageStr), placeholderImage: UIImage.init())
                peopleImage.sd_setImageWithURL(NSURL.init(string: newValue!.livePeopleIconStr), placeholderImage: UIImage.init())
                var countStr = newValue!.liveView
                let count = Int(countStr)!
                if count > 10000 {
                    let number = CGFloat(lroundf(Float(count) / 1000.0)) / 10.0
                    countStr = String(number) + "万"
                }
                peopleCount.text = countStr
                name.text = newValue!.livePeopleName
                title.text = newValue!.liveTitle
            }
        }
        get{
            return _liveObj
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        peopleImage.layer.cornerRadius = peopleImage.frame.height / 2
        peopleImage.layer.masksToBounds = true
        
        titleImage.layer.cornerRadius = 3
        titleImage.layer.masksToBounds = true
    }

}
