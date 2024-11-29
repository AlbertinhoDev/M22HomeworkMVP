import Foundation
import UIKit

protocol Builder {
    static func createMainView() -> UIViewController
}

class MainViewBuilder: Builder {
    static func createMainView() -> UIViewController {
        let view = MVPMainViewController()
        let networkService = NetworkService()
        let presenter = MainFilmPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
