//
//  PhotosViewController.swift
//  iPhotos
//
//  Created by abhishek.kas on 06/01/24.
//

import UIKit
import Combine

class PhotosViewController: UIViewController {
    //MARK: DataSource
    typealias DataSource = UICollectionViewDiffableDataSource<PhotosSection, PhotosCollectionViewCellViewModel>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<PhotosSection, PhotosCollectionViewCellViewModel>
    
    var photosCollectionView: UICollectionView?
    private var subscription = Set<AnyCancellable>()
    private var dataSource: DataSource?
    private var dataSourceSnapShop = DataSourceSnapshot()
    
    private let photosControllerViewModel: PhotosViewControllerViewModelProtocol
    private let layout: PhotosLayoutProtocol
    init(photosControllerViewModel: PhotosViewControllerViewModelProtocol,
         layout: PhotosLayoutProtocol){
        self.photosControllerViewModel = photosControllerViewModel
        self.layout = layout
        super.init(nibName: nil, bundle: nil)
        fetchPhotosData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func fetchPhotosData() {
        photosControllerViewModel.fetchPhotos()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished: break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: {[weak self] photosCollectionViewModels in
                guard let `self` = self else { return }
                guard  !photosCollectionViewModels.isEmpty else { return }
                self.configureCollectionViewLayout()
                self.applySnapShots(data: photosCollectionViewModels)
            }
            .store(in: &subscription)
    }
    
    private func configureCollectionViewLayout() {
        photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout.createLayout())
        photosCollectionView?.delegate = self
        photosCollectionView?.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: GridCollectionViewCell.reuseIdentifier)
        photosCollectionViewSetup()
        if let photosCollectionView {
            dataSource = DataSource(collectionView: photosCollectionView,
                                    cellProvider: { (collectionView, indexPath, photoViewModel) -> GridCollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.reuseIdentifier, for: indexPath) as? GridCollectionViewCell
                cell?.construct(photoViewModel: photoViewModel)
                return cell
            })
        }
    }
    
    private func photosCollectionViewSetup() {
        guard let photosCollectionView = photosCollectionView else { return }
        photosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(photosCollectionView)
        
        photosCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        photosCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        photosCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        photosCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    }
    
    private func applySnapShots(data: [PhotosCollectionViewCellViewModel]){
        dataSourceSnapShop = DataSourceSnapshot()
        dataSourceSnapShop.appendSections([PhotosSection.main])
        dataSourceSnapShop.appendItems(data)
        dataSource?.apply(dataSourceSnapShop)
    }
}


extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.photosControllerViewModel.didSelectPhoto(at: indexPath.item)
    }
}

