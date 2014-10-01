//
//  CanvasViewController.swift
//  CanvasTwo
//
//  Created by Alli Dryer on 9/29/14.
//  Copyright (c) 2014 Alli Dryer. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var deadImageView: UIImageView!
    @IBOutlet weak var excitedImageView: UIImageView!
    @IBOutlet weak var sadImageView: UIImageView!
    @IBOutlet weak var happyImageView: UIImageView!
    @IBOutlet weak var winkImageView: UIImageView!
    @IBOutlet weak var tongueImageView: UIImageView!
    @IBOutlet weak var downArrowImageView: UIImageView!
    
    var imageCenter: CGPoint!
    var newImageView: UIImageView!
    var onTongueEnded: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTrayMoved(gestureRecognizer: UIPanGestureRecognizer) {
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            imageCenter = trayView.center
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            if translation.y > 0 {
                trayView.center.y = translation.y + imageCenter.y
                downArrowImageView.transform = CGAffineTransformMakeRotation(translation.y * CGFloat(M_PI) / 180)
            } else if translation.y <= 0 {
                trayView.center.y = 0.1 * translation.y + imageCenter.y
                downArrowImageView.transform = CGAffineTransformMakeRotation(translation.y * CGFloat(M_PI) / 180)
            }
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            if velocity.y < 0 {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2.0, options: nil, animations: { () -> Void in
                    self.trayView.frame.origin.y = 370
                    self.downArrowImageView.transform = CGAffineTransformMakeRotation(0 * CGFloat(M_PI) / 180)
                    }, completion: { (finished: Bool) -> Void in
                })
            } else if velocity.y >= 0 {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2.0, options: nil, animations: { () -> Void in
                    self.downArrowImageView.transform = CGAffineTransformMakeRotation(180 * CGFloat(M_PI) / 180)
                    self.trayView.frame.origin.y = 528
                    }, completion: { (finished: Bool) -> Void in
                })
        
            }
        }
    }
    
    @IBAction func onTongue(gestureRecognizer: UIPanGestureRecognizer) {
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
        
            var imageView = gestureRecognizer.view as UIImageView
            newImageView = UIImageView(image: imageView.image)
            
            self.newImageView.userInteractionEnabled = true
            
            self.newImageView.frame.size = imageView.frame.size
            self.newImageView.frame.origin = view.convertPoint(imageView.frame.origin, fromView: trayView)
            view.addSubview(newImageView)
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            newImageView.center = location
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
           
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
