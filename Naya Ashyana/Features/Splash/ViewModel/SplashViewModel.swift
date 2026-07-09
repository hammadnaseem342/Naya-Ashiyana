import Foundation

final class SplashViewModel: SplashViewModelProtocol {

    // MARK: - Callbacks

    var onSplashFinished: (() -> Void)?

    // MARK: - Public Methods

    func startSplash() {
        
        print("startSplash Called")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {

            print("2.5 Seconds Completed")

            self.onSplashFinished?()

        }
    }
}
