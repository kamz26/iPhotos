//
//  GridLayout.swift
//  iPhotos
//
//  Created by abhishek.kas on 07/01/24.
//

import Foundation
import UIKit

protocol PhotosLayoutProtocol {
    func createLayout() -> UICollectionViewLayout
}

final class GridLayout: PhotosLayoutProtocol {
    
    func createLayout() -> UICollectionViewLayout {
        let spacing = InsetSpacing(top: 1, bottom: 1, leading: 1, trailing: 1)
        let padding: CGFloat = 10
        let itemWidth: CGFloat = ((UIScreen.main.bounds.size.width) - 2 * padding) / 3
        let itemHeight: CGFloat = (itemWidth) / 1
        let item = ComponentLayout.createItem(width: .absolute(itemWidth),
                                              height: .absolute(itemHeight),
                                              spacing: spacing)

        let group = ComponentLayout.createGroup(alignment: .horizontal,
                                                width: .fractionalWidth(1),
                                                height: .estimated(250),
                                                item: item, count: 3)

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout (section: section)
        return layout
    }
}

