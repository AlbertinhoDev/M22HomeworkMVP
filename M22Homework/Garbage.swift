//import Foundation
//import UIKit
//
//protocol NetworkServiceProtocol {
//    func getFilms(nameFilmForSearch: String, complition: @escaping (Result <[Model]?, Error>) -> Void)
//}
//
//class NetworkService: NetworkServiceProtocol {
//    
//    var model: [Model] = []
//    
//    let dispatchGroup = DispatchGroup()
//    
//    private var apiKeys = ["X-API-KEY" : "5a1aa54a-2e6d-40b4-aa36-e6950cc441ee"]
//    
//    func getFilms(nameFilmForSearch: String, complition: @escaping (Result<[Model]?, any Error>) -> Void) {
//        var serialNumber = 0
//        let nameFilm = nameFilmForSearch.lowercased().addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
//        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(nameFilm)"
//        guard let url = URL(string: urlString) else {return}
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = apiKeys
//        URLSession.shared.dataTask(with: request) {data, _, error in
//            if let error = error {
//                complition(.failure(error))
//                print("Error Networkervice shared")
//                return
//            }
//            do {
//                let obj = try JSONDecoder().decode(Quere.self, from: data!)
//                for i in obj.films {
//                    self.model.append(Model(nameRu: i.nameRu ?? "",
//                                            nameEn: i.nameEn ?? "",
//                                            type: i.type,
//                                            year: i.year,
//                                            description: i.description ?? "",
//                                            rating: i.rating,
//                                            posterUrlPreview: self.getImage(urlString: i.posterUrlPreview)))
//                    serialNumber += 1
//                }
//                print("data decoded")
//                complition (.success(self.model))
//            } catch {
//                print("Error Networkervice catch")
//                complition (.failure(error))
//                return
//            }
//            
//        } .resume()
//    }
//    
//    func getImage(urlString: String) -> UIImage {
//        var image = UIImage()
//        let url = URL(string: urlString)!
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            if error != nil {
//                print("Image not loaded")
//                return
//            }
//            if data != nil {
//                image = UIImage(data: data!) ?? UIImage()
//                print("Image loaded")
//            }
//        }
//        .resume()
//        return image
//    }
//}
//
