//
//  XUtils.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/6/21.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

/**LOG**/
func XLog_DEBUG<T>(message : T, methodFile: String = __FILE__, methodName: String = __FUNCTION__, lineNumber: Int = __LINE__){
    XLog_BASE("DEBUG", message: message, methodFile: methodFile,methodName: methodName, lineNumber: lineNumber)
}

func XLog_INFO<T>(message : T, methodFile: String = __FILE__, methodName: String = __FUNCTION__, lineNumber: Int = __LINE__){
    XLog_BASE("INFO", message: message, methodFile: methodFile,methodName: methodName, lineNumber: lineNumber)
}

func XLog_WARNNING<T>(message : T, methodFile: String = __FILE__, methodName: String = __FUNCTION__, lineNumber: Int = __LINE__){
    XLog_BASE("WARNNING", message: message, methodFile: methodFile,methodName: methodName, lineNumber: lineNumber)
}

func XLog_ERROT<T>(message : T, methodFile: String = __FILE__, methodName: String = __FUNCTION__, lineNumber: Int = __LINE__){
    XLog_BASE("ERROR", message: message, methodFile: methodFile,methodName: methodName, lineNumber: lineNumber)
}

private func XLog_BASE<T>(loginfo:String, message : T, methodFile: String, methodName: String, lineNumber: Int){
    #if Release
    #else
        let file: NSString = methodFile as NSString
        print("[\(loginfo)][\(file.lastPathComponent)]\(methodName)[\(lineNumber)]:\(message)")
    #endif
}

func ShowAlert(title: String?, message: String) {
    UIAlertView.init(title: title, message: message, delegate: nil, cancelButtonTitle: "确定").show()
}

func RGB(red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor{
    return RGB(red, green, blue, 1.0)
}

func RGB(red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor{
    return UIColor.init(red: red, green: green, blue: green, alpha: alpha)
}

/**只有在真机下才有效果**/
func DevicePlatform() -> String {
    var size = size_t.init()
    sysctlbyname("hw.machine", nil, &size, nil, 0)
    let machine = malloc(size)
    sysctlbyname("hw.machine", machine, &size, nil, 0)
    let platform = String.fromCString(UnsafePointer<Int8>(machine))
    free(machine)
    return platform!
}

func XScreenWidth() -> CGFloat{
    return UIScreen.mainScreen().bounds.size.width
}

func XScreenHeight() -> CGFloat{
    return UIScreen.mainScreen().bounds.size.height
}

