//
//  CameraViewController_services.swift
//
//  Created by LEOFALCON on 2017. 8. 6..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit
import AVFoundation

extension CameraViewController {
    
    @IBAction func activateFlash(_ sender: Any) {
        if captureDevice!.hasTorch {
            do {
                try captureDevice!.lockForConfiguration()
                captureDevice?.torchMode = captureDevice!.isTorchActive ? .off : .on
                
                captureDevice!.unlockForConfiguration()
            } catch { }
        }
    }
    
    func updateWeekLabel() {
        self.weekUILabel.text = "WEEK \(BabyStore.shared.getPregnantWeek().week)"
        self.weekUILabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 50 )
        //self.weekUILabel.font = UIFont.systemFont(ofSize: 50, weight: UIFontWeightThin)
        self.weekUILabel.textAlignment = .left
        //self.weekUILabel.layer.backgroundColor = UIColor.white.withAlphaComponent(0.7).cgColor
        self.weekUILabel.textColor = UIColor.white
        let labelWidth : CGFloat = self.weekUILabel.intrinsicContentSize.width + self.cameraView.frame.width/10
        let labelHeight : CGFloat = self.weekUILabel.intrinsicContentSize.height * 1.7
        
        let labelPointX : CGFloat = self.cameraView.frame.width/2 - (labelWidth/2)*1.7
        let labelPointY : CGFloat = self.cameraView.frame.height/50
        
        
        let point = CGPoint(x: labelPointX, y: labelPointY)
        let size = CGSize(width: labelWidth, height: labelHeight)
        
        //self.weekUILabel.layer.cornerRadius = labelHeight/2
        
        self.weekUILabel.layer.frame = CGRect(origin: point , size: size)
        self.cameraView.layer.addSublayer(self.weekUILabel.layer)
    }
    
    func updateBabyNameLabel() {
    
        self.babyNameUILabel.text = "\(BabyStore.shared.getName())"
        self.babyNameUILabel.font = UIFont(name:"AppleSDGothicNeo-Thin", size: 20)
        self.babyNameUILabel.textAlignment = .left
        self.babyNameUILabel.textColor = UIColor.white
        
        let babyLabelWidth : CGFloat = self.babyNameUILabel.intrinsicContentSize.width + self.cameraView.frame.width/10
        let babyLabelHeight : CGFloat = self.babyNameUILabel.intrinsicContentSize.height * 1.7
        
        let babyLabelPointX : CGFloat = self.cameraView.frame.width/2 - (babyLabelWidth/2) * 1.7
        let babyLabelPointY : CGFloat = self.cameraView.frame.height/30
        
        let point = CGPoint(x: babyLabelPointX, y: babyLabelPointY)
        let size = CGSize(width: babyLabelWidth, height: babyLabelHeight)
        
        self.babyNameUILabel.layer.frame = CGRect(origin: point, size: size)
        self.cameraView.layer.addSublayer(self.babyNameUILabel.layer)
    
    }
    
}

