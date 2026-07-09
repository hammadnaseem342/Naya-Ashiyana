import Foundation

protocol SplashViewModelProtocol: AnyObject {

    var onSplashFinished: (() -> Void)? { get set }

    func startSplash()
}
