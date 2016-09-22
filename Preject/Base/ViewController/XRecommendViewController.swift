//
//  XRecommendViewController.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/5/24.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

class XRecommendViewController: XBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let cellIdentifier = "liveCell"
    private let sectionIdentifier = "liveSection"
    private var backgroundView = UIView.init()
    private var imageScrollView = XScrollImageView.init()
    private var buttonScrollView = XScrollButtonView.init()
    private var buttonView = UIView.init()
    private var collectionView :UICollectionView?
    private var dataSource = NSMutableArray.init(capacity: 1)
    private let headerHeight:CGFloat = 220.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        loadData()
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
    
    //MARK: - initView
    func initView() {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.headerReferenceSize = CGSizeMake(XScreenWidth(), 30)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSizeMake(XScreenWidth() / 2, XScreenWidth() / 3)
        flowLayout.minimumLineSpacing = 0
//        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView!.mj_header = MJRefreshHeader.init(refreshingTarget: self, refreshingAction: "loadData")
        collectionView!.mj_header.ignoredScrollViewContentInsetTop = headerHeight
        let redView = UIView.init(frame: CGRectMake(0, 0, 100, 40))
        redView.backgroundColor = UIColor.redColor()
        collectionView!.mj_header.addSubview(redView)
        collectionView!.backgroundColor = UIColor.whiteColor()
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        view.addSubview(collectionView!)
        collectionView!.registerNib(UINib.init(nibName: "XLiveCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView?.registerNib(UINib.init(nibName: "XCategoryReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionIdentifier)
    
        let headerView = UIView.init(frame: CGRectMake(0, -headerHeight, XScreenWidth(), headerHeight))
        imageScrollView = XScrollImageView.init(frame: CGRectMake(0, 0, self.view.frame.width, 150))
        imageScrollView.initClick { (model) -> Void in
            let liveVC = XAloneLiveViewController.init()
            liveVC.live = model.live!
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(liveVC, animated: true)
            self.hidesBottomBarWhenPushed = false
            XLog_DEBUG(model)
        }
        headerView.addSubview(imageScrollView)
        
        buttonScrollView = XScrollButtonView.init(frame: CGRectMake(0, imageScrollView.frame.size.height, XScreenWidth(), 70))
        buttonScrollView.initClickBlock { (model) -> Void in
            XLog_DEBUG(model)
        }
        headerView.addSubview(buttonScrollView)
        collectionView!.contentInset = UIEdgeInsetsMake(headerHeight, 0, 0, 0);
        collectionView!.addSubview(headerView)
    }
    
    //MARK: - UICollectionViewDataSourcr && UICollectionViewDelegate
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let liveCatgory = dataSource[section] as! XLiveCategory
        if section == 0 {
            return 2
        }
        return liveCatgory.lives!.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let liveCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! XLiveCell
        liveCell.liveObj = getLiveObje(indexPath)
        return liveCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let live = getLiveObje(indexPath)
        let liveVC = XAloneLiveViewController.init()
        liveVC.live = live
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(liveVC, animated: true)
        hidesBottomBarWhenPushed = false
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: sectionIdentifier, forIndexPath: indexPath) as! XCategoryReusableView
            let liveCategory = dataSource[indexPath.section] as! XLiveCategory
            view.categoryTitle.text = liveCategory.title
            var str = "瞅瞅"
            if indexPath.section == 0 {
                str = "换一换"
            }
            view.categoryButton.setTitle(str, forState: .Normal)
            view.categoryButton.addTarget(self, action: "sectionButtonClick:", forControlEvents: .TouchUpInside)
            return view;
        }
        return UICollectionReusableView.init()
    }
    
    //MARK: - PRIVATE
    
    func sectionButtonClick(button :UIButton) {

        if button.titleForState(UIControlState.Normal) == "瞅瞅" {
            
        } else {
            collectionView?.reloadSections(NSIndexSet.init(index: 0))
        }
    }
    
    //MARK: - LOADDATA
    func loadData() {
        XAPIManager.getHomeLiveData { (array) -> Void in
            let recommentCate = array.firstObject as! XLiveCategory
            let classifyCate = array[1] as! XLiveCategory
            self.imageScrollView.resfreshViewWith(recommentCate)
            self.buttonScrollView.refreshViewWith(classifyCate)
            
            self.dataSource = NSMutableArray.init(array: array)
            self.dataSource.removeObjectsInRange(NSMakeRange(0, 2))
            self.collectionView?.reloadData()
            self.collectionView?.mj_header.endRefreshing()
        }
    }
    
    func getLiveObje(indexpath: NSIndexPath) -> XLiveObject {
        let category = self.dataSource[indexpath.section] as! XLiveCategory
        var model = category.lives![indexpath.row] as! XLiveModel
        if indexpath.section == 0 {
            let num = arc4random_uniform(UInt32(category.lives!.count))
//            let num = Int(arc4random()) % category.lives!.count
            model = category.lives![Int(num)] as! XLiveModel
        }
        return model.live!
    }
}
