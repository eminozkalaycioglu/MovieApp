
import Foundation
import Moya
import Result

typealias APIResult<T> = Result<T,MoyaError>

public final class ServiceManager {
    fileprivate let provider = MoyaProvider<MovieAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    fileprivate var jsonDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(Formatter.defaultDateFormatter)
        return jsonDecoder
    }

    public static let shared = ServiceManager()

    fileprivate func fetch<M: Decodable>(target: MovieAPI,
                                         completion: @escaping (_ result: APIResult<M>) -> Void ) {

        provider.request(target) { (result) in

            switch result {
            case .success(let response):
                
                do {
                   
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let mappedResponse = try filteredResponse.map(M.self,
                                                                  atKeyPath: nil,
                                                                  using: self.jsonDecoder,
                                                                  failsOnEmptyData: false)
                    completion(.success(mappedResponse))
                } catch MoyaError.statusCode(let response) {
                    if response.statusCode == 401 {

                    }
                    completion(.failure(MoyaError.statusCode(response)))
                } catch {
                    debugPrint("##ERROR parsing##: \(error.localizedDescription)")
                    let moyaError = MoyaError.requestMapping(error.localizedDescription)
                    completion(.failure(moyaError))
                }
            case .failure(let error):
                debugPrint("##ERROR service:## \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }


    func getPopularMovies(completion: @escaping (_ result: APIResult<MovieResponseModel>) -> Void ) {
        fetch(target: .getPopularMovies, completion: completion)
    }
    
    func getNowPlayingMovies(completion: @escaping (_ result: APIResult<NowPlayingMovieModel>) -> Void ) {
        fetch(target: .getNowPlayingMovies, completion: completion)
    }
    func getSelectedMovie(movieId: String,completion: @escaping (_ result: APIResult<SelectedMovieModel>) -> Void) {
        fetch(target: .getSelectedMovie(movieID: movieId), completion: completion)
    }
    
    func getSelectedMoviesImages(movieID: String, completion: @escaping (_ result: APIResult<SelectedMoviesImagesModel>) -> Void) {
        fetch(target: .getSelectedMoviesImages(movieID: movieID), completion: completion)
    }
    
    func getSelectedMoviesActors(movieID: String, completion: @escaping (_ result: APIResult<SelectedMoviesActorsModel>) -> Void) {
        fetch(target: .getSelectedMoviesActors(movieID: movieID), completion: completion)
    }
    
    func getSelectedMoviesVideo(movieID: String, completion: @escaping (_ result: APIResult<SelectedMoviesVideoModel>) -> Void) {
        fetch(target: .getSelectedMoviesVideo(movieID: movieID), completion: completion)
    }
    
    func getSelectedActorsImages(actorID: String, completion: @escaping (_ result: APIResult<SelectedActorsImagesModel>) -> Void) {
        fetch(target: .getSelectedActorsImages(actorID: actorID), completion: completion)
    }
    
    func getSelectedActor(actorID: String, completion: @escaping (_ result: APIResult<ActorsBioModel>) -> Void) {
        fetch(target: .getSelectedActor(actorID: actorID), completion: completion)
    }
    
    func getSelectedMoviesSimilarMovies(movieID: String, completion: @escaping (_ result: APIResult<SelectedMoviesSimilarMoviesModel>) -> Void) {
        fetch(target: .getSelectedMoviesSimilarMovies(movieID: movieID), completion: completion)
    }
    
    
    
    func getPopularTV(completion: @escaping (_ result: APIResult<PopularTVModel>) -> Void) {
        fetch(target: .getPopularTV, completion: completion)
    }
    
    func getTopRatedTV(completion: @escaping (_ result: APIResult<TopRatedTVModel>) -> Void) {
        fetch(target: .getTopRatedTV, completion: completion)
    }
    
    func getSelectedTVVideo(TVId: String, completion: @escaping (_ result: APIResult<SelectedTVVideoModel>) -> Void) {
        fetch(target: .getSelectedTVVideo(TVId: TVId), completion: completion)
    }
    func getSelectedTVActors(TVId: String, completion: @escaping (_ result: APIResult<SelectedTVActorsModel>) -> Void) {
        fetch(target: .getSelectedTVActors(TVId: TVId), completion: completion)
    }
    func getSelectedTVDetail(TVId: String, completion: @escaping (_ result: APIResult<SelectedTVDetailModel>) -> Void) {
        fetch(target: .getSelectedTVDetail(TVId: TVId), completion: completion)
    }
    
    
    func getSearchedMovies(word: String, completion: @escaping (_ result: APIResult<FoundMoviesModel>) -> Void) {
        fetch(target: .getSearchedMovies(word: word), completion: completion)
    }
    func getSearchedTV(word: String, completion: @escaping (_ result: APIResult<FoundTVModel>) -> Void) {
        fetch(target: .getSearchedTV(word: word), completion: completion)
    }
    
    

}

extension JSONDecoder.DateDecodingStrategy {
    static func hoDefaultDateDecodingStrategy() -> JSONDecoder.DateDecodingStrategy {
        return .custom({ (decoder) -> Date in
            guard let container = try? decoder.singleValueContainer(),
                let text = try? container.decode(String.self) else {
                    let error = DecodingError.Context(codingPath: decoder.codingPath,
                                                      debugDescription: "Could not decode date text")
                    throw DecodingError.dataCorrupted(error)
            }

            if let dateDouble = TimeInterval(text) {
                return Date(timeIntervalSince1970: dateDouble)
            } else {
                throw DecodingError.dataCorruptedError(in: container,
                                                       debugDescription: "Cannot decode date string \(text)")
            }
        })
    }
}

extension Formatter {
    static let defaultDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.init(identifier: "UTC")
        return formatter
    }()

}
