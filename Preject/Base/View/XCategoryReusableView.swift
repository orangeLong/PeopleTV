//
//  XCategoryReusableView.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/7/26.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

class XCategoryReusableView: UICollectionReusableView {

    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func btnClick(sender: UIButton) {
    }
    
}
