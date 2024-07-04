//
//  CoordinatorType.swift
//  CARDIZERR
//
//  Created by Osama Abu hdba on 25/08/2022.
//

import UIKit

protocol CoordinatorType {
    
   ///  Simply tells the coordinator to start, sub-protocols provide their own mechanism to implement this method, often it's not called directly
    func start()
}
