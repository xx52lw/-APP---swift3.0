//
//  LWCategoryViewController.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/22.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

// =================================================================================================================================
// MARK: - 分类视图控制器
class LWCategoryViewController: LWViewControllerBase {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        // Do any additional setup after loading the view.
    }
    
}
// =================================================================================================================================
// MARK: - 分类视图
extension LWCategoryViewController {
    /// 设置导航条
    func setNavBar() {
        
        let searchImage =  UIImage.getImageFromeBundleFile(fileName: "nav", imageName: "Nav_search")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: UIButton.creatButtonWithNormalBgImage(searchImage, target: self, action: #selector(rightSearchClick), for: UIControlEvents.touchUpInside))
        navigationItem.leftBarButtonItem = nil
    }
    func rightSearchClick() {
        print("rightSearchClick")
    }
}

////  NavigationViewController.swift
// Yundou////  Created by Slow on 16/1/3.
//  Copyright © 2016年 Slow. All rights reserved.
/*
import UIKit
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView:UITableView!
    var idleImages:NSMutableArray = []
    var refreshingImages:NSMutableArray = []
    var objectArr = [String]()
    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
// Do any additional setup after loading the view.   
        self.tableView = UITableView(frame: self.view.frame)
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
//注册tableViewCell      
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
//去除无数据的空tableViewCell        
        self.tableView.tableFooterView = UIView()
        for i ; i<10 ; i++ {
            self.objectArr.append("/(i)")
}
// 设置普通状态的动画图片       
        for (var i = 1; i<=60; i++) {
            var image:UIImage = UIImage(named: "dropdown_anim__000/(i)")! as UIImage
            idleImages.addObject(image)
}
// 设置普通状态的动画图片  
        for (var i = 1; i<=3; i++) {
            var image: UIImage = UIImage(named: "dropdown_loading_0/(i)")! as UIImage
            idleImages.addObject(image)
}
//定义动画刷新Header     
        let header:MJRefreshGifHeader = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: "headerRefresh")
//设置普通状态动画图片       
        header.setImages(idleImages as [AnyObject], forState: MJRefreshState.Idle)
//设置下拉操作时动画图片        
        header.setImages(refreshingImages as [AnyObject], forState: MJRefreshState.Pulling)
//设置正在刷新时动画图片       
        header.setImages(idleImages as [AnyObject], forState: MJRefreshState.Refreshing)
//设置mj_header     
        self.tableView.mj_header = header
//普通带文字下拉刷新的定义//      
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "headerRefresh")
//普通带文字上拉加载的定义//        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: "footerRefresh")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.  
}
//定义表格有多少行  
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{        return 1    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{        return objectArr.count    }
//定义tableViewCell样式   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell",forIndexPath:indexPath) as UITableViewCell                cell.textLabel?.text = "第/(self.objectArr[indexPath.row])行"
        return cell
}
//下拉刷新操作    
    func headerRefresh(){
//模拟数据请求，设置10s是为了便于观察动画      
        self.delay(10) { () -> () in
            self.objectArr.removeAll()
            self.i = 10
            for self.i ; self.i<20 ; self.i++ {
                self.objectArr.append("/(self.i)")
}
//结束刷新     
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
        }
}
//上拉加载操作    
    func footerRefresh(){
//模拟数据请求，设置10s是为了便于观察动画   
        self.delay(10) { () -> () in
            let j = self.i + 10
            for self.i ; self.i<j ; self.i++ {
                self.objectArr.append("/(self.i)")
}
//结束刷新     
            self.tableView.mj_footer.endRefreshing()
            self.tableView.reloadData()
        }
}
//延迟方法   
    func delay(time:Double,closure:() -> ()){        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)    }
}
*/
// =================================================================================================================================
