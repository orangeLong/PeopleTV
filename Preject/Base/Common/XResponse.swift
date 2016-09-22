//
//  XResponse.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/6/13.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

class XResponse: XBaseObject {

    internal var statusCode: Int?           /** 状态码 200 = success*/
    internal var statusString: String?      /** http请求状态本地化文本*/
    internal var desc: String?              /** 状态描述*/
    internal var error: NSError?            /** 错误信息*/
    internal var responseString: String?    /* 接口数据sting**/
    internal var responseObject: AnyObject? /** 接口返回数据*/
    
    internal func responseNoError() -> Bool{
        return statusCode == 200
    }
    
}
