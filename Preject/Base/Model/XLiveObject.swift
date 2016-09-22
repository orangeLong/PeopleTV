//
//  XLiveObject.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/6/23.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

class XLiveObject: XBaseObject {

    var liveTitle = ""
    var liveImageStr = ""
    var livePeopleName = ""
    var livePeopleIconStr = ""
    var liveLinkStr = ""
    var liveView = ""
    
    override init() {
        super.init()
    }
    
    init(dic: NSDictionary) {
        super.init()
        if let dicTitle = dic["title"] as? String {
            liveTitle = dicTitle
        }
        if let dicImageStr = dic["thumb"] as? String {
            liveImageStr = dicImageStr
        }
        if let dicPeopleName = dic["nick"] as? String {
            livePeopleName = dicPeopleName
        }
        if let dicView = dic["view"] as? String {
            liveView = dicView
        }
        if let dicPeopleIconStr = dic["avatar"] as? String {
            livePeopleIconStr = dicPeopleIconStr
        }
        if let dicUid = dic["uid"] as? String {
            liveLinkStr = getLinkStr(dicUid)
        }
    }
    
    func getLinkStr(uid: String) -> String {
        return "http://hls.quanmin.tv/live/\(uid)/playlist.m3u8"
    }
}
