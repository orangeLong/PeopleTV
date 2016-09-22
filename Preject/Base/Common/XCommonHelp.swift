//
//  XCommonHelp.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/6/20.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

class XCommonHelp: NSObject {

    typealias SuccessBlock = (isConnect: Bool)-> Void
    private static var successBlock: SuccessBlock?

    private static var isFirst = true
    static func isConnect(complete: SuccessBlock) {
        successBlock = complete
        if isFirst == false {
            complete(isConnect: afReachability.reachable)
        }
    }
    
    static func getCurrentTimeStamp() ->String {
        let dateFormatter = NSDateFormatter.init()
        dateFormatter.dateFormat = "MMddHHmmSS"
        let currentDate = NSDate()
        return dateFormatter.stringFromDate(currentDate)
    }
    
    private static let afReachability = AFNetworkReachabilityManager.sharedManager()
    static func setNetworkMonitor() {
        afReachability.setReachabilityStatusChangeBlock { (status) -> Void in
            
            if isFirst {
                if successBlock != nil {
                    successBlock!(isConnect: afReachability.reachable)
                    isFirst = false
                }
            }
            if status == AFNetworkReachabilityStatus.NotReachable {
                XLog_DEBUG("networkBreakOff")
            } else {
                XLog_DEBUG("networkIsConnected,\(status.rawValue)")
            }
        }
        afReachability.startMonitoring()
    }
}
