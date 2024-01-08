import Foundation
import UIKit

final class PhotosDetailViewController: UIViewController {
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var backButton: UIButton = {
      let backButton = UIButton()
      backButton.translatesAutoresizingMaskIntoConstraints = false
      backButton.setImage(UIImage(systemName: "arrowshape.left.fill"), for: .normal)
      backButton.tintColor = .black
      backButton.setTitleColor(.white, for: .normal)
      backButton.addTarget(self, action: #selector(backButtonClick(sender:)), for: .touchUpInside)
      return backButton
    }()
    
    private let selectedImage: UIImage
    private let aspectRatio: CGFloat
    
    init(selectedImage: UIImage, 
         aspectRatio: CGFloat){
        self.selectedImage = selectedImage
        self.aspectRatio = aspectRatio
        super.init(nibName: nil, bundle: nil)
        viewSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func viewSetup() {
        self.view.backgroundColor = .white
        self.view.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            photoImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            photoImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: aspectRatio)
        
        ])
        photoImageView.image = selectedImage
        navBar()
    }
    
    func navBar() {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .lightGray.withAlphaComponent(0.1)
      UINavigationBar.appearance().standardAppearance = appearance
      UINavigationBar.appearance().scrollEdgeAppearance = appearance
      let barButton = UIBarButtonItem(customView: backButton)
      self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc 
    func backButtonClick(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
