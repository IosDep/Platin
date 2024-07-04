//
//  UIImage+EX.swift
//  CARDIZERR
//
//  Created by Osama Abu Hdba on 16/04/2023.
//

import UIKit

extension UIImage {
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
    }
}

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }

    static func named(_ name: String) -> UIImage? {
        UIImage(named: name)
    }

    enum CompressImageErrors: Error {
          case invalidExSize
          case sizeImpossibleToReach
      }
      func compressImage(_ expectedSizeKb: Int, completion : (UIImage,CGFloat) -> Void ) throws {

          let minimalCompressRate :CGFloat = 0.4 // min compressRate to be checked later

          if expectedSizeKb == 0 {
              throw CompressImageErrors.invalidExSize // if the size is equal to zero throws
          }

          let expectedSizeBytes = expectedSizeKb * 1024
          let imageToBeHandled: UIImage = self
          var actualHeight : CGFloat = self.size.height
          var actualWidth : CGFloat = self.size.width
          var maxHeight : CGFloat = 841 //A4 default size I'm thinking about a document
          var maxWidth : CGFloat = 594
          var imgRatio : CGFloat = actualWidth/actualHeight
          let maxRatio : CGFloat = maxWidth/maxHeight
          var compressionQuality : CGFloat = 1
          var imageData:Data = imageToBeHandled.jpegData(compressionQuality: compressionQuality)!
          while imageData.count > expectedSizeBytes {

              if (actualHeight > maxHeight || actualWidth > maxWidth){
                  if(imgRatio < maxRatio){
                      imgRatio = maxHeight / actualHeight;
                      actualWidth = imgRatio * actualWidth;
                      actualHeight = maxHeight;
                  }
                  else if(imgRatio > maxRatio){
                      imgRatio = maxWidth / actualWidth;
                      actualHeight = imgRatio * actualHeight;
                      actualWidth = maxWidth;
                  }
                  else{
                      actualHeight = maxHeight;
                      actualWidth = maxWidth;
                      compressionQuality = 1;
                  }
              }
              let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
              UIGraphicsBeginImageContext(rect.size);
              imageToBeHandled.draw(in: rect)
              let img = UIGraphicsGetImageFromCurrentImageContext();
              UIGraphicsEndImageContext();
              if let imgData = img!.jpegData(compressionQuality: compressionQuality) {
                  if imgData.count > expectedSizeBytes {
                      if compressionQuality > minimalCompressRate {
                          compressionQuality -= 0.1
                      } else {
                          maxHeight *=  0.9
                          maxWidth *=  0.9
                      }
                  }
                  imageData = imgData
              }


          }

          completion(UIImage(data: imageData)!, compressionQuality)
      }

    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }

    public enum DataUnits: String {
        case byte, kilobyte, megabyte, gigabyte
    }

    func getSizeIn(_ type: DataUnits) -> Double {

        guard let data = self.pngData() else {
            return 0.0
        }

        var size: Double = 0.0

        switch type {
        case .byte:
            size = Double(data.count)
        case .kilobyte:
            size = Double(data.count) / 1024
        case .megabyte:
            size = Double(data.count) / 1024 / 1024
        case .gigabyte:
            size = Double(data.count) / 1024 / 1024 / 1024
        }

        return Double(size)
    }
}

extension String {
    func image(size: CGSize = CGSize(width: 80, height: 80)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

