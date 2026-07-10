//
//  OnboardingViewModelProtocol.swift
//  Naya Ashyana
//
//  Created by The Mac Store on 11/07/2026.
//

import Foundation

protocol OnboardingViewModelProtocol: AnyObject {

    // MARK: - Properties

    var items: [OnboardingItem] { get }

    var currentPage: Int { get set }

    var onPageChanged: ((Int) -> Void)? { get set }

    var onFinish: (() -> Void)? { get set }

    // MARK: - Methods

    func nextPage()

    func skip()

    func item(at index: Int) -> OnboardingItem
}
