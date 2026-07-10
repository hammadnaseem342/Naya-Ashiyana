//
//  OnboardingCollectionViewCell.swift
//  Naya Ashyana
//
//  Created by The Mac Store on 11/07/2026.
//

import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {

    // MARK: - Identifier

    static let identifier = "OnboardingCollectionViewCell"

    // MARK: - UI Components

    private lazy var illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(
            red: 107/255,
            green: 107/255,
            blue: 107/255,
            alpha: 1.0
        )
        return label
    }()


    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension OnboardingCollectionViewCell {

    func configureUI() {

        backgroundColor = .white

    }

    func setupViews() {

        contentView.addSubview(illustrationImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)

    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            // MARK: - Illustration

            illustrationImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 30),

            illustrationImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            illustrationImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            illustrationImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.48),

            // MARK: - Title

            titleLabel.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor, constant: 32),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),

            // MARK: - Subtitle

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),

            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])
    }
}
// MARK: - Configuration

extension OnboardingCollectionViewCell {

    func configure(with item: OnboardingItem) {

        illustrationImageView.image = UIImage(named: item.imageName)

        titleLabel.text = item.title

        subtitleLabel.text = item.subtitle
    }
}
