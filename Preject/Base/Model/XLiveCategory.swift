//
//  XLiveCategory.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/6/23.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

class XLiveCategory: XBaseObject {
    var title = ""
    var signKey = ""
    var thumb = ""
    var lives: NSArray?
    
    init(array: NSArray) {
        super.init()
        let bigArray = NSMutableArray.init(capacity: 1)
        for element in array {
            if let dic = element as? NSDictionary {
                let liveModel = XLiveModel.init(dic: dic)
                bigArray.addObject(liveModel)
            }
        }
        lives = NSArray.init(array: bigArray)
    }
    
    init(dic: NSDictionary) {
        super.init()
        if let dicName = dic["name"] as? String {
            title = dicName
        }
        if let dicSlug = dic["slug"] as? String {
            signKey = dicSlug
        }
        if let dicThumb = dic["thumb"] as? String {
            thumb = dicThumb
        }
    }
}
