//
//  UIImageView+Extensions.swift
//  Futballory
//
//  Created by Aldair Carrillo on 11/11/23.
//

import UIKit

extension UIImageView {
    
    func rounded(cornerRadius: CGFloat) -> UIImage? {
        let size = bounds.size
        let rect = bounds
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        let cornerPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        cornerPath.addClip()
        context.addPath(cornerPath.cgPath)
        image?.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
