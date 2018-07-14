//
//  AdViewController.swift
//  FoodTracker
//
//  Created by Chun Kong on 2018/7/14.
//  Copyright © 2018年 chenzhengang. All rights reserved.
//

import UIKit
import Lottie

class AdViewController: UIViewController {

    // 用于 AdViewController 销毁后的回调
    var completion: (() -> Void)?
    
    //Lottie动画
    private var boatAnimation: LOTAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Lottie动画
        // Create Boat Animation
        boatAnimation = LOTAnimationView(name: "Boat_Loader")
        
        //也可以url导入
        //let animationView = LOTAnimationView(contentsOf: URL(string: "https://github.com/airbnb/lottie-ios/raw/master/Example/Assets/PinJump.json")!)
        
        // Set view to full screen, aspectFill
        
        boatAnimation!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        boatAnimation!.contentMode = .scaleAspectFill
        boatAnimation!.frame = view.bounds
        //循环播放
        boatAnimation!.loopAnimation = true
        //播放速度
        boatAnimation!.animationSpeed = 1.1
        // Add the Animation
        
        //先加的是底，预先把主菜单页面加载进底部
        let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MealTableViewController") as! MealTableViewController
        self.view.addSubview(vc1.view)
        self.view.addSubview(boatAnimation!)
        boatAnimation?.play()
        
        //延迟
        let time: TimeInterval = 2.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            UIView.animate(withDuration: 2, animations: { [weak self] in
                self?.boatAnimation?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                self?.boatAnimation?.alpha = 0
            }){ [weak self] (isFinish) in
                self?.dismissAdView()
            }
        }
    }
    
    @objc func dismissAdView() {
        self.view.removeFromSuperview()
        //print("完成")
        self.completion?()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
