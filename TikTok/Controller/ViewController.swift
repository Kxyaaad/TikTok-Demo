//
//  ViewController.swift
//  TikTok
//
//  Created by Kxy on 2020/6/13.
//  Copyright © 2020 Kxy. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
   
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    
    var awemeList = [AwemeList]()
    
    var videoJsonIndex = 12
    
    var currentPage = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        awemeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        cell.prepareForReuse()
        cell.aweme = awemeList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        videoJsonIndex -= 1
        getList()
        
        currentPage = tableView.indexPathsForVisibleRows!.last!.row
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadingView.startAnimating()
        tableView.isPagingEnabled = true
        tableView.showsVerticalScrollIndicator = false
        getList()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func getList() {
        let url = URL(string: TikTolURL.baseLocak + String(videoJsonIndex) + TikTolURL.feedFile)
        getAwelist(url: url!)
        
        
    }

    func getAwelist(url: URL) {
        do {
            let feed = try Feed(fromURL: url)
            if let awemeList = feed.awemeList {
                self.awemeList += awemeList
                loadingView.stopAnimating()
                self.tableView.reloadData()
            }
        } catch  {
            debugPrint("网络获取错误", error)
        }
    }

}

