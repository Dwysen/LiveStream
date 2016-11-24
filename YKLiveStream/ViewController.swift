//
//  ViewController.swift
//  YKLiveStream
//
//  Created by Dwysen on 16/10/17.
//  Copyright © 2016年 Dwysen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bgImg: UIImageView!
    @IBAction func tapBack(sender: AnyObject) {
        ijkplayerview.shutdown()
        navigationController?.popViewControllerAnimated(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func tapGift(sender: AnyObject) {
        let car = UIImageView(image: UIImage(named: "porsche"))
        view.addSubview(car)
        UIView.animateWithDuration(1, animations: { 
            UIView.animateWithDuration(1) {
                let carheight:CGFloat = 125
                let carwidth:CGFloat = 250
                car.frame = CGRect(x: self.view.center.x - carwidth/2, y: self.view.center.y - carheight/2, width: carwidth, height: carheight)
            }
            
            }) { (com) in
                UIView.animateWithDuration(1, animations: {
                    car.alpha = 0
                    }, completion: { (completion) in
                        car.removeFromSuperview()
                })

        }
  
        
        
        
        
    }
    
    @IBAction func tapLike(sender: AnyObject) {
        let likeView = DMHeartFlyView()
//      likeView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//      likeView.center = CGPoint(x: btnLike.frame.origin.x, y: btnLike.frame.origin.y)
        
        //点赞弹出爱心效果
        likeView.frame.size = CGSize(width: 40, height: 40)
        likeView.center = btnLike.center
        view.addSubview(likeView)
        likeView.animateInView(view)
        
        //点赞按钮变大变小效果
         let btnAnime = CAKeyframeAnimation(keyPath: "transform.scale")
        btnAnime.values =     [1.0,0.7,0.5,0.3,0.5,0.7,1.0,1.2,1.5,1.0]
        btnAnime.keyTimes = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
        sender.layer.addAnimation(btnAnime, forKey: "show")
        
        
        
    }
    @IBOutlet weak var btnGift: UIButton!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var btnLike: UIButton!
    
    var live:YKCell!
    var playerview:UIView!
    var ijkplayerview:IJKFFMoviePlayerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgUrl = NSURL(string: "http://img.meelive.cn/" + live.portrait)
        bgImg.kf_setImageWithURL(imgUrl!)
        let blurEffect = UIBlurEffect(style: .Light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = bgImg.frame
       bgImg.addSubview(effectView)
        
        playerview = UIView(frame: view.bounds)
        view.addSubview(playerview)
        
        
        setPlayerView()
        
        bringBtnToFront()

    }

    func bringBtnToFront(){
    view.bringSubviewToFront(btnBack)
    view.bringSubviewToFront(btnGift)
    view.bringSubviewToFront(btnLike)

    
    }
    
    
    
    func  setPlayerView(){
        ijkplayerview = IJKFFMoviePlayerController(contentURLString: live.url, withOptions: nil)
        let pv = ijkplayerview.view
        pv.frame = playerview.bounds
//        pv.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        playerview.insertSubview(pv, atIndex: 1)
        ijkplayerview.scalingMode = .AspectFit
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if !self.ijkplayerview.isPlaying(){
           ijkplayerview.prepareToPlay()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

