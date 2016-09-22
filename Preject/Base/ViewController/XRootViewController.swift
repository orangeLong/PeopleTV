//
//  XRootViewController.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/5/16.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

class XRootViewController: UITabBarController {
    
//    private let recomment = "推荐"
//    private let column = "栏目"
//    private let live = "直播"
//    private let mine = "我的"
    
    private let recommentImage = "tabbar_home"
    private let columnImage = "tabbar_game"
    private let liveImage = "tabbar_room"
    private let mineImage = "tabbar_me"

    private let recommentSelImage = "tabbar_home_sel"
    private let columnSelImage = "tabbar_game_sel"
    private let liveSelImage = "tabbar_room_sel"
    private let mineSelImage = "tabbar_me_sel"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        XCommonHelp.setNetworkMonitor()
        initView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        let recommentNC = viewControllerWithNagitaion(recomment, imageName: recommentImage, selImageName: recommentSelImage)
        let columnNC = viewControllerWithNagitaion(column, imageName: columnImage, selImageName: columnSelImage)
        let liveNC = viewControllerWithNagitaion(live, imageName: liveImage, selImageName: liveSelImage)
        let mineNC = viewControllerWithNagitaion(mine, imageName: mineImage, selImageName: mineSelImage)
        viewControllers = [recommentNC, columnNC, liveNC, mineNC]
    }
    
    func viewControllerWithNagitaion(name: String, imageName: String, selImageName: String) -> UINavigationController {
        var baseVC = XBaseViewController.init()
        if name == recomment {
            baseVC = XRecommendViewController.init()
        } else if name == column {
            baseVC = XColumnViewController.init()
        } else if name == live {
            baseVC = XLiveViewController.init()
        } else if name == mine {
            baseVC = XMineViewController.init()
        }
        baseVC.title = name
        let image = UIImage.init(named: imageName)
        baseVC.tabBarItem.image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let selImage = UIImage.init(named: selImageName)
        baseVC.tabBarItem.selectedImage = selImage?.imageWithRenderingMode(.AlwaysOriginal)
        let navVC = XBaseNavigationController.init(rootViewController: baseVC)
        let rightImage = UIImage.init(named: columnImage)
        baseVC.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: rightImage!.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: "rightItemClick:")
        return navVC
    }
    
    func rightItemClick(sender: AnyObject) {
        let nextVC = UIViewController.init()
        nextVC.view.backgroundColor = UIColor.redColor()
        let nv = selectedViewController as! XBaseNavigationController
        nv.pushViewController(nextVC, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
