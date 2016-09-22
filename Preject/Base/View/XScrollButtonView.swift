//
//  XScrollButtonView.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/6/22.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

class XScrollButtonView: XBaseView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    typealias ClickBlock = (model: XLiveModel) -> Void
    
    internal var clickBlock = ClickBlock?()
    private let viewTag = 300
    private var scrollView = UIScrollView.init()
    private var priLiveCategory: XLiveCategory?
    
    override init(frame: CGRect) {
        let cgFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 70)
        super.init(frame: cgFrame)
        scrollView = UIScrollView.init(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        addSubview(scrollView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
    resetViewFromDatasource
    */
    
    internal func refreshViewWith(liveCatergory: XLiveCategory) {
        for view in scrollView.subviews {
            view.removeFromSuperview()
        }
        priLiveCategory = liveCatergory
        let lives = liveCatergory.lives!
        scrollView.contentSize = CGSizeMake(CGFloat(50 * lives.count), 0)
        for(var i = 0; i < lives.count; i++) {
            let live = lives[i] as! XLiveModel
            let button = UIButton.init(type: UIButtonType.Custom)
            let width: CGFloat = 50
            button.layer.cornerRadius = width / 2
            button.layer.masksToBounds = true
            button.frame = CGRectMake(width * CGFloat(i), 0, width, width)
            button.sd_setBackgroundImageWithURL(NSURL.init(string: live.thumb), forState: UIControlState.Normal)
            button.tag = viewTag + i
            button.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
            scrollView.addSubview(button)
            
            let height: CGFloat = 20
            let label = UILabel.init(frame: CGRectMake(button.frame.origin.x, button.frame.size.height, width, height))
            label.backgroundColor = UIColor.whiteColor()
            label.textAlignment = .Center
            label.alpha = 0.5
            label.font = UIFont.systemFontOfSize(10)
            label.textColor = UIColor.grayColor()
            label.text = live.title
            scrollView.addSubview(label)
        }
    }
    
    func buttonClick(button: UIButton) {
        if clickBlock != nil {
            clickBlock!(model: priLiveCategory!.lives!.objectAtIndex(button.tag - viewTag) as! XLiveModel)
        }
    }
    
    internal func initClickBlock(click: ClickBlock) {
        clickBlock = click
    }
}
