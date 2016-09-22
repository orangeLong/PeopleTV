//
//  XLiveModel.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/6/24.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

class XLiveModel: XBaseObject {

    var thumb = ""
    var title = ""
    var live : XLiveObject?
    init(dic: NSDictionary) {
        super.init()
        if let dicThumb = dic["thumb"] as? String {
            thumb = dicThumb
        }
        
        if let dicTitle = dic["title"] as? String {
            title = dicTitle
        }
        
        if let dicLive = dic["link_object"] as? NSDictionary {
            live = XLiveObject.init(dic: dicLive)
        }
        
        if live != nil {
            if thumb == "" {
                thumb = live!.liveImageStr
            }
            
            if title == "" {
                title = live!.liveTitle
            }
        }
    }
}
