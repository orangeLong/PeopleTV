//
//  XColumnViewController.swift
//  PeopleSwift
//
//  Created by LiX i n long on 16/5/24.
//  Copyright © 2016年 LiX i n long. All rights reserved.
//

import UIKit

class XColumnViewController: XBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    internal var datasource = NSMutableArray.init(capacity: 1)
    private var collectionView :UICollectionView?
    private let cellSpace: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initData()
        self.initView()
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
    //MARK: - initData
    func initData() {
        XAPIManager.getCategoryLiveData(nil) { (categoryArray) -> Void in
            self.datasource = NSMutableArray.init(array: categoryArray)
            self.collectionView?.reloadData()
        }
    }
    
    //MARK: - initView
    
    func initView() {
        let collectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let width = (view.frame.size.width - cellSpace * 5) / 3
        collectionViewFlowLayout.itemSize = CGSizeMake(width, width * 1.5)
        collectionViewFlowLayout.minimumLineSpacing = cellSpace
        collectionViewFlowLayout.minimumInteritemSpacing = cellSpace
        collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, cellSpace, 0, cellSpace)
        
        let collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: collectionViewFlowLayout)
        self.collectionView = collectionView
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        
        collectionView.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        let category = datasource[indexPath.row] as! XLiveCategory
        var imageView: UIImageView
        if cell.contentView.subviews.count == 0 {
            imageView = UIImageView.init(frame: cell.contentView.bounds)
            cell.contentView.addSubview(imageView)
        } else {
            imageView = cell.contentView.subviews.first as! UIImageView
        }
        imageView.sd_setImageWithURL(NSURL.init(string: category.thumb))
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSizeMake(150, 80)
        let vc = XLiveCategoryViewController.init(collectionViewLayout: flowLayout)
        let category = datasource[indexPath.row] as! XLiveCategory
        vc.vcSlug = category.signKey
        navigationController?.pushViewController(vc, animated: true)
    }
}
