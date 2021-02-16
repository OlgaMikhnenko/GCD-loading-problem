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
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL,
                  let imageData = try? Data(contentsOf: url)
            else { return }
            DispatchQueue.main.sync {
                self.image = UIImage (data: imageData)
            }
        }
    }
    
    fileprivate func loginAlert () {
        let ac = UIAlertController(title: "Зарегестрированы?", message: "Введите логин и пароль", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (usernameTF) in
            usernameTF.placeholder = "Введите логин"
        }
        ac.addTextField { (passwordTF) in
            passwordTF.placeholder = "Введите пароль"
        }
        self.present(ac, animated: true, completion: nil)
    }
    
    fileprivate func delay (_ delay : Int, closure : @escaping () -> () ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds (delay) ) {
            closure()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage ()
        delay(3) {
            self.loginAlert()
        }
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
