//
//  SecondViewController.swift
//  GCD loading problem
//
//  Created by Helga on 15.02.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    fileprivate var imageURL : URL?
    fileprivate var image : UIImage? {
        get {
            return imageView.image
        }
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    fileprivate func fetchImage () {
        imageURL = URL (string: "https://www.imgonline.com.ua/examples/bee-on-daisy.jpg")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        guard let url = imageURL,
              let imageData = try? Data(contentsOf: url)
        else { return }
        self.image = UIImage (data: imageData)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage ()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
