//
//  OnboardingCoordinator.swift
//  Naya Ashyana
//
//  Created by The Mac Store on 11/07/2026.
//

import UIKit

final class OnboardingCoordinator: Coordinator {

    // MARK: - Properties

    let navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Coordinator

    func start() {

        let viewModel = OnboardingViewModel()

        viewModel.onFinish = { [weak self] in
            self?.showLogin()
        }

        let viewController = OnboardingViewController(
            viewModel: viewModel
        )

        navigationController.setViewControllers(
            [viewController],
            animated: true
        )
    }
}

// MARK: - Navigation

private extension OnboardingCoordinator {

    func showLogin() {

        print("Navigate to Login Screen")

        // TODO:
        // Navigate to LoginCoordinator here
    }
}
