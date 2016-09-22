//
//  XAPIManager.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/6/20.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

class XAPIManager: XBaseObject {
    typealias ReturnBlock = (array: NSArray) -> Void
    
    private static let apiPart = "/json/page"
    private static let apiJson = "/info.json"
    private static let apiHeader = "/app-data"
    private static let apiLive = "/appv2-index"
    
    private static let apiCategory = "/json/categories"
    private static let apiList = "/list.json"
    /**
    getHomeHeaderViewData
    
    - parameter back: imageModels
    */
    static func getHomeHeaderData(back: ReturnBlock) {
        XNetworkManger.requestWithUrl(getHeaderApi(), params: nil, httpMethod: HTTPMethod.HTTPMethodGet) { (response) -> Void in
            if response.responseNoError() {
                if let resDic = response.responseObject as? NSDictionary {
                    if let headerArray = resDic["app-focus"] as? NSArray {
                        let imageMoadels = NSMutableArray.init(capacity: 1)
                        for eachDic in headerArray {
                            let modle = XLiveModel.init(dic: eachDic as! NSDictionary)
                            imageMoadels.addObject(modle)
                        }
                        back(array: imageMoadels)
                    }
                }
            } else {
                XProgressHUD.showErrorMessage(response.desc)
            }
        }
    }
    /**
    getHomeLiveData
    
    - parameter backBlcok: liveModel
    */
    static func getHomeLiveData(backBlcok: (liveArray: NSArray) -> Void) {
        XCommonHelp.isConnect { (isConnect) -> Void in
            XNetworkManger.requestWithUrl(getLiveApi(), params: nil, httpMethod: HTTPMethod.HTTPMethodGet) { (response) -> Void in
                if response.responseNoError() {
                    if let resDic = response.responseObject as? NSDictionary {
                        let backArray = liveDic(resDic)
                        backBlcok(liveArray: backArray)
                    }
                }
            }
        }
    }
    
    /**
    getColumnData
    
    - parameter backBlock: return catrgoryArray
    */
    static func getCategoryLiveData(slug: String?, backBlock:(categoryArray: NSArray) -> Void) {
        XCommonHelp.isConnect { (isConnect) -> Void in
            if isConnect {
                XNetworkManger.requestWithUrl(getCategoryApi(slug), params: nil, httpMethod: HTTPMethod.HTTPMethodGet, callback: { (response) -> Void in
                    let bigArray = NSMutableArray.init(capacity: 1)
                    if let array = response.responseObject as? NSArray {
                        for element in array {
                            if let dic = element as? NSDictionary {
                                let cate = XLiveCategory.init(dic: dic)
                                bigArray.addObject(cate)
                            }
                        }
                        backBlock(categoryArray: bigArray)
                    } else if let bigDic = response.responseObject as? NSDictionary {
                        if let dataArray = bigDic["data"] as? NSArray {
                            for element in dataArray {
                                if let dic = element as? NSDictionary {
                                    let live = XLiveModel.init(dic: dic)
                                    bigArray.addObject(live)
                                }
                            }
                            backBlock(categoryArray: bigArray)
                        }
                    }
                })
            }
        }
    }
    
    /**
    parseHomeClassificationData
    
    - parameter categoryArray: jsonData
    
    - returns: buttonObject models
    */
    private static func classificationArray(categoryArray: NSArray) -> NSArray {
        let muArray = NSMutableArray.init(capacity: 1)
        for dic in categoryArray {
            let buttonObj = XLiveObject.init(dic: dic as! NSDictionary)
            muArray.addObject(buttonObj)
        }
        return muArray
    }
    /**
    getHomeAllData
    
    - parameter baseDic: responseJson
    
    - returns: categorys
    */
    private static func liveDic(baseDic: NSDictionary) -> NSArray {
        let bigArray = NSMutableArray.init(capacity: 1)
        if let listArray = baseDic["list"] as? NSArray {
            for element in listArray {
                let listDic = element as! NSDictionary
                let slug = listDic["slug"] as! String
                let category = XLiveCategory.init(array: baseDic[slug] as! NSArray)
                category.title = listDic["name"] as! String
                category.signKey = slug
                bigArray.addObject(category)
            }
        }
        XLog_DEBUG(bigArray)
        return bigArray
    }
    
    /**
    getHomeAllData
    
    - parameter headerBlock: returnHeaderModels homeBlock: returnLiveData
    */
    static func getHomeData(headerBlock: (headerArray: NSArray) -> Void, homeBlock: (liveArray: NSArray) -> Void) {

        XCommonHelp.isConnect{ (isConnect) -> Void in
            if !isConnect {
                ShowAlert(nil, message: NoNetworkMessage)
                return
            }
            getHomeHeaderData({ (array) -> Void in
                headerBlock(headerArray: array)
            })
            getHomeLiveData({ (liveArray) -> Void in
                homeBlock(liveArray: liveArray)
            })
        }
    }
    /**
    getHomeHeaderIndexRequestUrl
    
    - returns: urlstring
    */
    private static func getHeaderApi() -> String {
        return apiPart + apiHeader + apiJson
    }
    /**
    getHomeLiveRequestUrl
    
    - returns: urlString
    */
    private static func getLiveApi() -> String {
        return apiPart + apiLive + apiJson + "?" + XCommonHelp.getCurrentTimeStamp()
    }
    
    private static func getCategoryApi(slug: String?) -> String {
        var str = ""
        if !(slug == nil) {
            str = "/" + slug!
        }
        return apiCategory + str + apiList + "?" + XCommonHelp.getCurrentTimeStamp()
    }
    
}

