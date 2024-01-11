//
//  AdvertisementViewController.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/11/24.
//

import UIKit

class AdvertisementViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "광고 화면"
        
        let leftBarButtonItemImage = UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftBarButtonItemImage, style: .plain, target: self, action: #selector(leftBarButtonItemTapped))
    }
    
    @objc func leftBarButtonItemTapped() {
        dismiss(animated: true, completion: nil)
    }

}
