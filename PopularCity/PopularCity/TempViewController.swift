//
//  TempViewController.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/14/24.
//

import UIKit

class TempViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
        
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 2
    }
    

    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: 34 * 3)
                let estimatedSize = textView.sizeThatFits(size)
                
                textView.constraints.forEach { (constraint) in
                
                  /// 180 이하일때는 더 이상 줄어들지 않게하기
                    if estimatedSize.height <= 34 {
                    
                    }
                    else {
                        if constraint.firstAttribute == .height {
                            constraint.constant = estimatedSize.height
                        }
                    }
                }
    }


}
