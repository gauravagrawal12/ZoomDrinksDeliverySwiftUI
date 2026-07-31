//
//  NavigationRouter.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 10/07/26.
//

import SwiftUI
import Combine

@MainActor
final class NavigationRouter: ObservableObject {

    static let shared = NavigationRouter()

    @Published var path = NavigationPath()

    private init() {}

    // MARK: - Push

    func push<T: Hashable>(_ destination: T) {
        path.append(destination)
    }

    // MARK: - Pop

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    // MARK: - Pop Multiple

    func pop(count: Int) {
        guard count > 0 else { return }

        let removeCount = min(count, path.count)
        path.removeLast(removeCount)
    }

    // MARK: - Pop To Root

    func popToRoot() {
        path.removeLast(path.count)
    }

    // MARK: - Pop To Index

    func popToIndex(_ index: Int) {

        guard index >= 0 else { return }

        let removeCount = path.count - index

        guard removeCount > 0 else { return }

        path.removeLast(removeCount)
    }

    // MARK: - Set New Root

    func makeRoot<T: Hashable>(_ destination: T) {
        path = NavigationPath()
        path.append(destination)
    }

    // MARK: - Reset Root

    func resetRoot() {
        path = NavigationPath()
    }
}
