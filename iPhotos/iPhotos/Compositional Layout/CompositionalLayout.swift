
import Foundation
import UIKit

enum PhotosSection {
    case main
}
enum CompositionalGroupAlignment {
    case vertical
    case horizontal
}

struct InsetSpacing {
  var top: CGFloat
  var bottom: CGFloat
  var leading: CGFloat
  var trailing: CGFloat
  
  static let zero: InsetSpacing = .init(top: 0, bottom: 0, leading: 0, trailing: 0)
}
struct ComponentLayout {
  static func createItem(width: NSCollectionLayoutDimension,
                         height: NSCollectionLayoutDimension,
                         spacing: InsetSpacing) -> NSCollectionLayoutItem {
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: width,
                                                                         heightDimension: height))
    item.contentInsets = NSDirectionalEdgeInsets(top: spacing.top,
                                                 leading: spacing.leading,
                                                 bottom: spacing.bottom,
                                                 trailing: spacing.trailing)
    return item
  }

  static func createGroup(alignment: CompositionalGroupAlignment,
                          width: NSCollectionLayoutDimension,
                          height: NSCollectionLayoutDimension,
                          items: [NSCollectionLayoutItem]) -> NSCollectionLayoutGroup {
    switch alignment {
    case .vertical:
      return NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: width,
                                                                                 heightDimension: height),
                                              subitems: items)
    case .horizontal:
      return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: width,
                                                                                   heightDimension: height),
                                                subitems: items)
    }
  }

  static func createGroup(alignment: CompositionalGroupAlignment,
                          width: NSCollectionLayoutDimension,
                          height: NSCollectionLayoutDimension,
                          item: NSCollectionLayoutItem,
                          count: Int) -> NSCollectionLayoutGroup {
    switch alignment {
    case .vertical:
      return NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: width,
                                                                                 heightDimension: height),
                                              subitem: item,
                                              count: count)
    case .horizontal:
      return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: width,
                                                                                   heightDimension: height),
                                                subitem: item,
                                                count: count)
     }
   }
}
