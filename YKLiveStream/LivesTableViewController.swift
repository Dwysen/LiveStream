//
//  LivesTableViewController.swift
//  YKLiveStream
//
//  Created by Dwysen on 16/10/17.
//  Copyright © 2016年 Dwysen. All rights reserved.
//

import UIKit
import Just
import Kingfisher

class LivesTableViewController: UITableViewController {

    
    var livesUrl = "http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1"
    
    var list : [YKCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrl()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadUrl), forControlEvents: .ValueChanged)

    }
    
    func loadUrl(){
    Just.post(livesUrl) { (result) in
        guard let json = result.json as? NSDictionary else {
            return
        }
        let lives = YKLiveStream(fromDictionary: json).lives
        // map方法，将[YKLive]里的每一个个体转换为YKCell后生成一个新的[YKCell]
        //只选出需要的4个数据
            self.list = lives.map({ (live) -> YKCell in
            return YKCell(portrait: live.creator.portrait, nick: live.creator.nick, location: live.city, viewers: live.onlineUsers, url: live.streamAddr)
        })
//        dump(self.list)
        NSOperationQueue.mainQueue().addOperationWithBlock({ 
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        })
  
        }
  
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 600
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return list.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! LiveTableViewCell
        let live = list[indexPath.row]
        cell.lableNick.text = live.nick
        cell.labelAddr.text = live.location
        cell.labelViewNumber.text = "\(live.viewers)"
        let imgUrl = NSURL(string: "http://img.meelive.cn/" + live.portrait)
        
        cell.imgBigPor.kf_setImageWithURL(imgUrl!)
        
        cell.imgPor.layer.cornerRadius = 5
        cell.imgPor.layer.masksToBounds = true
 
        cell.imgPor.kf_setImageWithURL(imgUrl!)
        
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let dest = segue.destinationViewController as? ViewController
        dest?.live = list[(tableView.indexPathForSelectedRow?.row)!]
    }
    
    
    
    
    
}
