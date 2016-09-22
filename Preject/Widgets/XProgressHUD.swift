//
//  XProgressHUD.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/6/22.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

class XProgressHUD: XBaseObject {
    private static var progressHUD = JGProgressHUD.init()
    /**
    showErrorView
    
    - parameter message: alertMesage
    */
    static func showErrorMessage(message: String?) {
        let errorView = JGProgressHUDErrorIndicatorView.init()
        showBaseProgress(message, indicatorView: errorView)
    }
    /**
    showSuccessView
    
    - parameter message: alertMessage
    */
    static func showSuccessMessage(message: String?) {
        let successView = JGProgressHUDSuccessIndicatorView.init()
        showBaseProgress(message, indicatorView: successView)
    }
    /**
    showLoadingView
    
    - parameter message: alertMessage
    */
    static func showLoadingMessage(message: String?) {
        showBaseProgress(message, indicatorView: nil)
    }
    /**
    dismissProgressHUD
    */
    static func dismissProgressHUD() {
        progressHUD.dismiss()
    }
    /**
    baseView
    
    - parameter message:       alertMessage
    - parameter indicatorView: showView
    */
    private static func showBaseProgress(message: String?, indicatorView: JGProgressHUDIndicatorView?) {
        let hud = JGProgressHUD.init(style: JGProgressHUDStyle.Dark)
        progressHUD = hud
        hud.indicatorView = indicatorView
        hud.textLabel.text = message
        hud.showInView(currentWindow())
        hud.dismissAfterDelay(2.0)
    }
    /**
    getCurrentWindow
    
    - returns: currentWindow
    */
    private static func currentWindow() -> UIView {
        return UIApplication.sharedApplication().delegate!.window!!
    }
    
}
