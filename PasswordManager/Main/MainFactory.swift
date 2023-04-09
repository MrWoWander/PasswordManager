//
//  MainFactory.swift
//  PasswordManager
//
//  Created by Mikhail Ivanov on 09.04.23.
//

import PMProtocols
import SwiftUI

final class MainFactory: FactoryViewProtocol {
    func build() -> AnyView {
        let deps = MainDependencies()
        let viewModel = MainViewModel(deps: deps)
        let view = MainView(viewModel: viewModel)
        return .init(view)
    }
}
