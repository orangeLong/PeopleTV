//
//  XScrollImageView.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/5/24.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

typealias clickBlock = (model: XLiveModel) -> Void

class XScrollImageView: XBaseView, UIScrollViewDelegate {
    
    private let viewTage = 200
    private let pageHeight: CGFloat = 20.0
    private var backView = UIScrollView.init()
    private var pageView = UIPageControl.init()
    internal var pageLabel = UILabel.init()
    private var timer = NSTimer.init()
    private var count = 0
    private var priLiveCate: XLiveCategory?
    
    internal var funcBlock = clickBlock?()
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backView = UIScrollView.init(frame: frame)
        backView.backgroundColor = UIColor.redColor()
        backView.pagingEnabled = true
        backView.showsHorizontalScrollIndicator = false
        backView.showsVerticalScrollIndicator = false
        backView.bounces = false
        backView.delegate = self
        backView.contentSize = CGSize.init(width: frame.size.width, height: frame.size.height)
        addSubview(backView)
        
        pageLabel = UILabel.init(frame: CGRect.init(x: 0, y: frame.size.height - pageHeight, width: frame.size.width, height: pageHeight))
        pageLabel.font = UIFont.systemFontOfSize(12.0)
        pageLabel.backgroundColor = UIColor.blackColor()
        pageLabel.textColor = UIColor.whiteColor()
        pageLabel.alpha = 0.5
        addSubview(pageLabel)
        
        pageView = UIPageControl.init(frame: pageLabel.frame)
        pageView.numberOfPages = 0
        pageView.addTarget(self, action: "pageControlClicked:", forControlEvents: .ValueChanged)
        addSubview(pageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /****/
    
    func resfreshViewWith(liveCategory: XLiveCategory) {
        priLiveCate = liveCategory
        let lives = liveCategory.lives!
        pageView.numberOfPages = lives.count
        backView.contentSize = CGSize.init(width: frame.size.width * CGFloat(lives.count), height: frame.size.height)
        for button in subviews {
            if button is UIButton {
                button.removeFromSuperview()
            }
        }
        for(var i = 0; i < lives.count; i++) {
            let model = lives[i] as! XLiveModel
            let button = UIButton.init(type: .Custom)
            let number = CGFloat(arc4random() % 255) / 255.0
            let color = UIColor.init(red: number, green: number, blue: number, alpha: 1.0)
            button.backgroundColor = color
            button.frame = CGRectMake(CGFloat(i) * frame.size.width, 0, frame.size.width, frame.size.height)
            button.tag = viewTage + i
            button.sd_setBackgroundImageWithURL(NSURL.init(string: model.thumb), forState: UIControlState.Normal)
            button.addTarget(self, action: "buttonClick:", forControlEvents: .TouchUpInside)
            backView.addSubview(button)
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(imageScrollTime, target: self, selector: "viewScroll", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)

    }
    
    func pageControlClicked(sender: AnyObject) {
        let index = pageView.currentPage
        backView.setContentOffset(CGPointMake(CGFloat(index) * backView.bounds.size.width, 0), animated: true)
    }
    
    func viewScroll() {
        var x: CGFloat = 0.0
        if Int(backView.contentOffset.x + backView.bounds.size.width) != Int(backView.contentSize.width) {
            x = backView.contentOffset.x + backView.bounds.size.width
        }
        backView.setContentOffset(CGPointMake(x, 0), animated: true)
        XLog_DEBUG("=====\(count++)=====\(NSDate())")
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
//        timer.fireDate = NSDate.distantFuture()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.bounds.size.width
        pageView.currentPage = Int(index)
//        timer.fireDate = NSDate.distantPast()
    }
    
    func buttonClick(button: UIButton) {
        if (funcBlock != nil) {
            funcBlock!(model: priLiveCate!.lives![button.tag - viewTage] as! XLiveModel)
        }
    }
    
    func initClick(click: clickBlock) {
        funcBlock = click
    }
    
}
