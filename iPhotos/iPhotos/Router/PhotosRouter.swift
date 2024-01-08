import Foundation
import UIKit

protocol PhotosRoutingProtocol{
    var viewController: UIViewController? { get set }
    func openDetailsView(selectedImage: UIImage?, aspectRatio: CGFloat)
}

final class PhotosRouter: PhotosRoutingProtocol {
    weak var viewController: UIViewController?
    func openDetailsView(selectedImage: UIImage?, aspectRatio: CGFloat) {
        if let selectedImage {
            let detailsController = PhotosDetailViewController(selectedImage: selectedImage, aspectRatio: aspectRatio)
            let navController = UINavigationController(rootViewController: detailsController)
            viewController?.presentInSlideInSlideOutAnimation(navController, animated: true, completion: nil)
        }
    }
}


extension UIViewController: UIViewControllerTransitioningDelegate {
    @objc
    func presentInSlideInSlideOutAnimation(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if animated {
            viewController.transitioningDelegate = self
            viewController.modalPresentationStyle = .overFullScreen
        }
        
        DispatchQueue.main.async{
            self.present(viewController, animated: animated, completion: completion)
        }
    }
}
