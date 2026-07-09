//
//  SplashCoordinator.swift
//  Naya Ashyana
//
//  Created by The Mac Store on 10/07/2026.
//

import UIKit

final class SplashCoordinator: Coordinator {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {

        let viewModel = SplashViewModel()

        viewModel.onSplashFinished = { [weak self] in
            print("Coordinator Callback")

            self?.showLogin()

        }

        let viewController = SplashViewController(
            viewModel: viewModel
        )

        navigationController.setViewControllers(
            [viewController],
            animated: false
        )
    }
}
private extension SplashCoordinator {

    func showLogin() {

        print("Navigate to Login")

    }

}
