//
//  OnboardingViewModel.swift
//  Naya Ashyana
//
//  Created by The Mac Store on 11/07/2026.
//

import Foundation

final class OnboardingViewModel: OnboardingViewModelProtocol {

    // MARK: - Properties

    var onPageChanged: ((Int) -> Void)?

    var onFinish: (() -> Void)?

    var currentPage: Int = 0

    let items: [OnboardingItem] = [

        OnboardingItem(
            imageName: "onboarding_1",
            title: "Find Verified\nRental Properties",
            subtitle: "Explore thousands of verified properties in your desired location."
        ),

        OnboardingItem(
            imageName: "onboarding_2",
            title: "Connect Directly\nWith Owners",
            subtitle: "No brokers, no commission.\nTalk directly with property owners."
        ),
        OnboardingItem(
                imageName: "onboarding_3",
                title: "Save & Book\nYour Perfect Home",
                subtitle: "Save your favourite\nproperties and book visits\nwith ease."
            )
    ]

    // MARK: - Methods

    func item(at index: Int) -> OnboardingItem {
        items[index]
    }

    func nextPage() {

        if currentPage < items.count - 1 {

            currentPage += 1
            onPageChanged?(currentPage)

        } else {

            onFinish?()

        }
    }

    func skip() {

        onFinish?()

    }
}
