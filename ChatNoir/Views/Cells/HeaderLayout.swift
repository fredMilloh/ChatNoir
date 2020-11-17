//
//  HeaderLayout.swift
//  ChatNoir
//
//  Created by fred on 17/11/2020.
//

import UIKit

class HeaderLayout: UICollectionViewFlowLayout {
//pour que la cover du header grossisse quand la collectionView descend,
//cover car après la visual effect view (avant dans l'arbo du story)
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true //autorise le changement de layout
    }
    
    // fonction qui récupére le x et le y du header, dans un tableau [x, y], quand la collection scroll
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let actualLayout = super.layoutAttributesForElements(in: rect) //position actuel du header
        actualLayout?.forEach({ (layout) in
            if layout.representedElementKind == UICollectionView.elementKindSectionHeader {
                guard let collection = collectionView else { return }
                let contentOffsetY = collection.contentOffset.y //le x restant à 0, on traite seulement le y
                print(contentOffsetY) // exemple du tableau avec un y, en - quand collection descend
                // quand la collection descend, le y devient négatif
                if contentOffsetY < 0 {
                    //on change la hauteur du header en ajoutant le y, la largeur reste celle de l'écran
                    let height = layout.frame.height - contentOffsetY //taille du header -(-y)= +y
                    //on crée une nouvelle vueFrame rect
                    let frame = CGRect(x: 0.0, y: contentOffsetY, width: collection.frame.width, height: height)
                    layout.frame = frame //on affecte la nouvelle frame
                }
            }
        })
        return actualLayout
    }
}
