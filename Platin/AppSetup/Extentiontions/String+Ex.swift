//
//  String+Ex.swift
//  Cardizerr Admin
//
//  Created by Osama Abu Hdba on 13/08/2023.
//

import Foundation
import UIKit

extension String {
    func width(with font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: font.lineHeight)
        let actualSize = self.boundingRect(with: maxSize,
                                           options: [.usesLineFragmentOrigin],
                                           attributes: [.font: font],
                                           context: nil)
        return ceil(actualSize.width)
    }
}
