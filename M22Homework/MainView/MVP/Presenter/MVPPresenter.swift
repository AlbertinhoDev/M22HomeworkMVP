import Foundation

protocol MainViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getFilms(nameFilmForSearch: String)
    var films: [Model]? {get set}
}

final class MainFilmPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    var films: [Model]?
    var nameFilmForSearch: String?
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    func getFilms(nameFilmForSearch: String ) {
        networkService.getFilms(nameFilmForSearch: nameFilmForSearch) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch  result {
                case .success(let films):
                    self.films = films
                    self.view?.succes()
                case .failure(let error):
                    print("Error MVPPresenter -> getFilms")
                    self.view?.failure(error: error)
                }
            }
        }
    }
    private func showDescription(nameFilm: String) {
        print(nameFilm)
    }
}
