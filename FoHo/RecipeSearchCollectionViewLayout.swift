//
//  RecipeSearchCollectionViewLayout.swift
//  FoHo
//
//  Created by Brittney Ryn on 4/14/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import UIKit

protocol RecipeSearchLayoutDelegate : UICollectionViewDelegate {
    // 1
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath,
                        withWidth:CGFloat) -> CGFloat
    // 2
    func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
}

class RecipeSearchCollectionViewLayout: UICollectionViewLayout {
    // This keeps a reference to the delegate
    var delegate: RecipeSearchLayoutDelegate!
    
    //These are two public properties for configuring the layout: the number of columns and the cell padding
    var numberOfColumns = 2
    var cellPadding: CGFloat = 6.0
    
    /*This is an array to cache the calculated attributes. When you call prepareLayout(), you’ll calculate the attributes f
     or all items and add them to the cache. When the collection view later requests the layout attributes, you can be efficient
     and query the cache instead of recalculating them every time.
     */
    private var cache = [UICollectionViewLayoutAttributes]()
    
    /* This declares two properties to store the content size. contentHeight is incremented as photos are added, and contentWidth 
     is calculated based on the collection view width and its content inset.
    */
    private var contentHeight: CGFloat  = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        let width = collectionView!.bounds.width
        return width - (insets.left + insets.right)
    }

    override func prepare(){
        /*
         This method is called whenever a layout operation is about to take place. It’s your opportunity to prepare and perform any 
         calculations required to determine the collection view size and the positions of the items.
         */
        
        if cache.isEmpty {
            // 2
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            for column in 0 ..< numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth )
            }
            var column = 0
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            
            // 3
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
                
                let indexPath = IndexPath(row: item, section: 0)
                
                // 4
                let width = columnWidth - cellPadding * 2
                let photoHeight = delegate.collectionView(collectionView: collectionView!, heightForPhotoAtIndexPath: indexPath,
                                                          withWidth:width)
                let annotationHeight = delegate.collectionView(collectionView: collectionView!,
                                                               heightForAnnotationAtIndexPath: indexPath, withWidth: width)
                let height = cellPadding +  photoHeight + annotationHeight + cellPadding
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                // 5
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                
                // 6
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                
               // column = column >= (numberOfColumns - 1) ? 0 : (column = 1 + column)
                if column >= (numberOfColumns - 1){
                    column = 0
                }
                else{
                    column += 1
                }
            }
        }
    
    }
    

    
    override var collectionViewContentSize: CGSize {
        /*
            In this method, you have to return the height and width of the entire collection view content — not just the visible content. 
            The collection view uses this information internally to configure its scroll view content size.
         */

        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        /*
         In this method you need to return the layout attributes for all the items inside the given rectangle. You return the attributes to
         the collection view as an array of UICollectionViewLayoutAttributes.
    */
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    

    
}
