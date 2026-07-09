import UIKit

final class SplashViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: SplashViewModelProtocol

    // MARK: - UI Components

    private var displayLink: CADisplayLink?
    private var animationStartTime: CFTimeInterval = 0
    private let animationDuration: CFTimeInterval = 2.5
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(
            red: 216/255,
            green: 240/255,
            blue: 217/255,
            alpha: 1.0
        )
        return view
    }()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "splash_logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Naya Ashiyana"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(
            red: 0/255,
            green: 106/255,
            blue: 66/255,
            alpha: 1.0
        )
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Find your perfect rental home — without brokers"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(
            red: 64/255,
            green: 73/255,
            blue: 61/255,
            alpha: 0.8
        )
        return label
    }()

    private lazy var buildingsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "splash_buildings")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progressTintColor = UIColor(
            red: 0/255,
            green: 106/255,
            blue: 66/255,
            alpha: 1.0
        )

        progress.trackTintColor = UIColor(
            red: 141/255,
            green: 175/255,
            blue: 134/255,
            alpha: 1.0
        )
        progress.progress = 0
        return progress
    }()

    // MARK: - Initializer

    init(viewModel: SplashViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Splash View Loaded")

        configureUI()
        setupViews()
        setupConstraints()
        bindViewModel()
    }
    
    deinit {

        displayLink?.invalidate()

    }
}
private extension SplashViewController {

    func configureUI() {
        view.backgroundColor = .white
    }

    func setupViews() {

        view.addSubview(backgroundView)

        backgroundView.addSubview(logoImageView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(subtitleLabel)
        backgroundView.addSubview(buildingsImageView)
        backgroundView.addSubview(progressView)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            // MARK: - Background View

            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // MARK: - Logo

            logoImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -90),
            logoImageView.widthAnchor.constraint(equalToConstant: 96),
            logoImageView.heightAnchor.constraint(equalToConstant: 96),

            // MARK: - Title

            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),

            // MARK: - Subtitle

           

                subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),

                subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            

            // MARK: - Buildings Illustration

            buildingsImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            buildingsImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            buildingsImageView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),

            buildingsImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.34),
            // MARK: - Progress View

            progressView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 40),
            progressView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -40),
            progressView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            progressView.heightAnchor.constraint(equalToConstant: 9)
        ])
    }

    func bindViewModel() {
        print("bindViewModel Called")
        startProgressAnimation()

            viewModel.startSplash()
    }
    private func startProgressAnimation() {

        progressView.progress = 0

        animationStartTime = CACurrentMediaTime()

        displayLink?.invalidate()

        displayLink = CADisplayLink(
            target: self,
            selector: #selector(updateProgress)
        )

        displayLink?.add(
            to: .main,
            forMode: .common
        )
    }
    @objc
    private func updateProgress() {

        let elapsed = CACurrentMediaTime() - animationStartTime

        let progress = min(Float(elapsed / animationDuration), 1.0)

        progressView.progress = progress

        if progress >= 1.0 {

            displayLink?.invalidate()
            displayLink = nil

        }
    }
    
}
