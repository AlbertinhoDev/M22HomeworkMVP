import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func getFilms(nameFilmForSearch: String, complition: @escaping (Result <[Model]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    var model: [Model] = []
    
    private var apiKeys = ["X-API-KEY" : "5a1aa54a-2e6d-40b4-aa36-e6950cc441ee"]
    
    func getFilms(nameFilmForSearch: String, complition: @escaping (Result<[Model]?, Error>) -> Void) {
        let nameFilm = nameFilmForSearch.lowercased().addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(nameFilm)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = apiKeys
        
        var models: [Model] = []
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                complition(.failure(error))
                print("Error Network service shared")
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(Quere.self, from: data!)
                let group = DispatchGroup()
                for i in obj.films {
                    var model = Model(nameRu: i.nameRu ?? "",
                                      nameEn: i.nameEn ?? "",
                                      type: i.type ?? "",
                                      year: i.year ?? "",
                                      description: i.description ?? "",
                                      filmLength: i.filmLength ?? "",
                                      rating: i.rating ?? "",
                                      posterUrlPreview: nil) // Изначально присваиваем nil
                    if i.posterUrlPreview != nil {
                        group.enter() // Увеличиваем счетчик для dispatch group
                        self.getImage(urlString: i.posterUrlPreview!) { image in
                            model.posterUrlPreview = image // Обновляем модель
                            models.append(model)
                            group.leave() // Уменьшаем счетчик
                        }
                    } else {
                        return
                    }

                }
                group.notify(queue: .main) { // Уведомляем, когда все изображения загружены
                    self.model = models // Обновляем основной массив
                    print("data decoded")
                    complition(.success(self.model))
                }
                
            } catch {
                print("Error Network service catch")
                complition(.failure(error))
                return
            }
        }.resume()
    }

    func getImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                print("Image not loaded")
                completion(nil) // Возвращаем nil
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                print("Image loaded")
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

