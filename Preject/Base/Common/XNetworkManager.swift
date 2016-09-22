//
//  XNetworkManger.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/6/13.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

enum HTTPMethod: String{
    case HTTPMethodOptions = "OPTIONS"
    case HTTPMethodGet = "GET"
    case HTTPMethodHead = "HEAD"
    case HTTPMethodPost = "POST"
    case HTTPMethodPut = "PUT"
    case HTTPMethodDelete = "DELETE"
    case HTTPMethodTrace = "TRACE"
    case HTTPMethodConnect = "CONNECT"
};

typealias NETWORK_CALLBACK = (response: XResponse) -> Void

class XNetworkManger: XBaseObject {

    static func requestCheckNetworkWithUrl(url: String, params: NSDictionary?, httpMethod: HTTPMethod, callback: NETWORK_CALLBACK) {
        XCommonHelp.isConnect { (isConnect) -> Void in
            if !isConnect {
                ShowAlert(nil, message: NoNetworkMessage)
            }
            requestWithUrl(url, params: params, httpMethod: httpMethod, callback: callback)
        }
    }
    
    /** 请求，完整urlstring 或者 部分urlstring*/
    static func requestWithUrl(url: String, params: NSDictionary?, httpMethod: HTTPMethod, callback: NETWORK_CALLBACK) {
        
        let manager = AFHTTPSessionManager.init(baseURL: NSURL.init(string: API_HOST))
        var error: NSError? = nil
        let urlString = url + getUrlMustSuffix()
        let totalUrlString = NSURL.init(string: urlString, relativeToURL: manager.baseURL)!.absoluteString
        let urlRequest = manager.requestSerializer.requestWithMethod(httpMethod.rawValue, URLString: totalUrlString, parameters: params, error: &error)
        XLog_INFO("httpMethod = \(httpMethod.rawValue) url = \(totalUrlString) body = \(params)")
        if error != nil {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let response = XResponse.init()
                response.desc = error?.description
                callback(response: response)
            })
        }
        let task = manager.dataTaskWithRequest(urlRequest) { (response, responseObject, error) -> Void in
            XLog_INFO("response = \(response), responseObject = \(responseObject), error = \(error)")
            let xresponse = XResponse.init()
            let httpResponse = response as! NSHTTPURLResponse
            xresponse.statusCode = httpResponse.statusCode
            xresponse.statusString = NSHTTPURLResponse.localizedStringForStatusCode(httpResponse.statusCode)
            if error != nil {
                xresponse.error = error
                callback(response: xresponse)
            } else {
                xresponse.responseObject = responseObject
                callback(response: xresponse)
            }
        }
        task.resume()

    }
    /*
    /** 请求，部分url*/
    static func requestWithPartUrl(url: String, params: NSDictionary, httpMethod: HTTPMethod, callback: NETWORK_CALLBACK) {
        let totalUrl = self.totalUrlWithPartUrl(url)
        requestWithTotalUrl(totalUrl, params: params, httpMethod: httpMethod, callback: callback)
    }
    /** getTotalUrl*/
    static func totalUrlWithPartUrl(partUrl: String) -> String {
        return partUrl + XPrifix.API_HOST
    }
    */
    /** 用于url后面必要的参数*/
    private static func getUrlMustSuffix() -> String {
        return ""
    }
    
}
