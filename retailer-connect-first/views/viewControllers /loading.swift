//
//  LoadingView.swift
//  My Trane Rewards
//
//  Created by Pixiders on 18/02/2020.
//  Copyright © 2020 Pixiders. All rights reserved.
//

import UIKit
import Lottie

class Loading: UIView {
    
    @IBOutlet weak var loadingAnimationView: LottieAnimationView!
    
    class func instanceFromNib() -> Loading {
        return UINib(nibName:"loading", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Loading
    }
    func present(size:CGRect){
        self.frame = size
        self.loadingAnimation()
    }
    private func loadingAnimation(){
        loadingAnimationView.animation = LottieAnimation.named("Animation - 1699600264479 (1).json")
        loadingAnimationView.play()
    }
    func dismiss(){
        self.loadingAnimationView.stop()
        self.removeFromSuperview()
    }
}

