//
//  OnboardingViewController.swift
//  Naya Ashyana
//
//  Created by The Mac Store on 11/07/2026.
//

import UIKit

final class OnboardingViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: OnboardingViewModelProtocol

    // MARK: - Initializer

    init(viewModel: OnboardingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Components

    private lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true

        collectionView.register(
            OnboardingCollectionViewCell.self,
            forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier
        )

        return collectionView

    }()
    
    private lazy var pageControl: UIPageControl = {

        let pageControl = UIPageControl()

        pageControl.translatesAutoresizingMaskIntoConstraints = false

        pageControl.numberOfPages = viewModel.items.count
        pageControl.currentPage = 0

        pageControl.currentPageIndicatorTintColor = UIColor(
            red: 0/255,
            green: 106/255,
            blue: 66/255,
            alpha: 1
        )

        pageControl.pageIndicatorTintColor = .systemGray4

        return pageControl

    }()
    
    private lazy var skipButton: UIButton = {

        let button = UIButton(type: .system)

        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle("Skip", for: .normal)

        button.setTitleColor(.black, for: .normal)

        button.titleLabel?.font = .systemFont(
            ofSize: 17,
            weight: .medium
        )

        return button

    }()
    
    private lazy var nextButton: UIButton = {

        let button = UIButton(type: .system)

        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle("Next", for: .normal)

        button.setTitleColor(.white, for: .normal)

        button.titleLabel?.font = .systemFont(
            ofSize: 17,
            weight: .semibold
        )

        button.backgroundColor = UIColor(
            red: 0/255,
            green: 106/255,
            blue: 66/255,
            alpha: 1
        )

        button.layer.cornerRadius = 14

        return button

    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setupViews()
        setupConstraints()
        bindViewModel()
        updateButtons(for: 0)
    }
    
    @objc
    private func nextButtonTapped() {

        viewModel.nextPage()

    }

    @objc
    private func skipButtonTapped() {

        viewModel.skip()

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)

        pageControl.currentPage = page
        viewModel.currentPage = page

        updateButtons(for: page)
    }
    
    private func updateButtons(for page: Int) {

        if page == viewModel.items.count - 1 {

            nextButton.setTitle("Get Started", for: .normal)

        } else {

            nextButton.setTitle("Next", for: .normal)

        }
    }
}



// MARK: - Private Methods

private extension OnboardingViewController {
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        nextButton.addTarget(
            self,
            action: #selector(nextButtonTapped),
            for: .touchUpInside
        )
        
        skipButton.addTarget(
            self,
            action: #selector(skipButtonTapped),
            for: .touchUpInside
        )
    }
    
    func setupViews() {
        
        view.addSubview(collectionView)
        
        view.addSubview(pageControl)
        
        view.addSubview(skipButton)
        
        view.addSubview(nextButton)
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            // MARK: - Collection View
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -32),
            
            // MARK: - Page Control
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -28),
            
            // MARK: - Skip Button
            
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            skipButton.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor),
            
            // MARK: - Next Button
            
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            
            nextButton.widthAnchor.constraint(equalToConstant: 120),
            
            nextButton.heightAnchor.constraint(equalToConstant: 52)
            
        ])
    }
    
    func bindViewModel() {
        
        viewModel.onPageChanged = { [weak self] page in
            
            guard let self = self else { return }
            
            self.pageControl.currentPage = page
            
            let indexPath = IndexPath(item: page, section: 0)
            
            self.collectionView.scrollToItem(
                at: indexPath,
                at: .centeredHorizontally,
                animated: true
            )
            
            self.updateButtons(for: page)
        }
        updateButtons(for: 0)
    }
}

extension OnboardingViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {

        return viewModel.items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OnboardingCollectionViewCell.identifier,
            for: indexPath
        ) as? OnboardingCollectionViewCell else {

            return UICollectionViewCell()
        }

        let item = viewModel.item(at: indexPath.item)

        cell.configure(with: item)

        return cell
    }
}
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        return collectionView.bounds.size
    }
}
