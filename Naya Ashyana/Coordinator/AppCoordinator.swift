import UIKit

final class AppCoordinator: Coordinator {

    // MARK: - Properties

    let navigationController: UINavigationController

    private var splashCoordinator: SplashCoordinator?

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Coordinator

    func start() {

        splashCoordinator = SplashCoordinator(
            navigationController: navigationController
        )

        splashCoordinator?.start()
    }
}
