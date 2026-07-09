//
//  Coordinator.swift
//  Naya Ashyana
//
//  Created by The Mac Store on 10/07/2026.
//

import UIKit

protocol Coordinator: AnyObject {

    var navigationController: UINavigationController { get }

    func start()

}
