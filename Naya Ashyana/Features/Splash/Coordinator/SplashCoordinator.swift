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

            self?.showOnboarding()
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

    func showOnboarding() {

        let onboardingCoordinator = OnboardingCoordinator(
            navigationController: navigationController
        )

        onboardingCoordinator.start()
    }
}
