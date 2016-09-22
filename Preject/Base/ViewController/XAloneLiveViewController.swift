//
//  XAloneLiveViewController.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/7/11.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit
import AVFoundation

class XAloneLiveViewController: UIViewController {
    
    internal var live = XLiveObject.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.redColor()
//        self.navigationController?.navigationBarHidden = true
        
        let player = AVPlayer.init(URL: NSURL.init(string: live.liveLinkStr)!)
        let playerLayer = AVPlayerLayer.init(player: player)
        playerLayer.frame = view.bounds
        playerLayer.backgroundColor = UIColor.greenColor().CGColor
        view.layer.addSublayer(playerLayer)
        player.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
