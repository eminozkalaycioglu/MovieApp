
import Foundation
import Moya

enum MovieAPI {
    case getPopularMovies
    case getNowPlayingMovies
    case getSelectedMovie(movieID: String)
    case getSelectedActor(actorID: String)
    case getSelectedMoviesActors(movieID: String)
    case getSelectedMoviesVideo(movieID: String)
    case getSelectedMoviesSimilarMovies(movieID: String)
    case getSelectedMoviesImages(movieID: String)
    case getSelectedActorsImages(actorID: String)
    
    case getSearchedMovies(word: String)
    case getSearchedTV(word: String)
    
    case getPopularTV
    case getTopRatedTV
    case getSelectedTVDetail(TVId: String)
    case getSelectedTVVideo(TVId: String)
    case getSelectedTVActors(TVId: String)
    
    

}

extension MovieAPI: TargetType {
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    
    var apiKey:String {
        return "8b16402c7db94bc7a84483ebad226430"
    }
    
    public var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    
    // 2
    public var path: String {
        switch self {
        case .getSearchedMovies( _):
            return "/search/movie"
        case .getSearchedTV( _):
            return "/search/tv"
            
        case .getNowPlayingMovies:
            return "/movie/now_playing"
        case .getSelectedActorsImages(let actorID):
            return "/person/\(actorID)/images"
        case .getSelectedMoviesImages(let movieID):
            return "/movie/\(movieID)/images"
        case .getPopularMovies:
            return "/discover/movie"
        case .getSelectedActor(let actorID):
            return "/person/\(actorID)"
        case .getSelectedMovie(let movieID):
            return "/movie/\(movieID)"
        case .getSelectedMoviesActors(let movieID):
            return "/movie/\(movieID)/casts"
        case .getSelectedMoviesVideo(let movieID):
            return "/movie/\(movieID)/videos"
        case .getSelectedMoviesSimilarMovies(let movieID):
            return "/movie/\(movieID)/similar"
            
            
        case .getPopularTV:
            return "/tv/popular"
        case .getTopRatedTV:
            return "/tv/top_rated"
            
        case .getSelectedTVDetail(let TVId):
            return "/tv/\(TVId)"
        case .getSelectedTVVideo(let TVId):
            return "/tv/\(TVId)/videos"
        case .getSelectedTVActors(let TVId):
            return "/tv/\(TVId)/credits"
        }
    }
    

    // 3
    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    // 4
    public var sampleData: Data {
        return Data()
    }
    

    public var task: Task {
        switch self {
           
        case .getSearchedTV(let word):
            return .requestParameters(
                parameters: [
                    "api_key": apiKey,
                    "language": "tr-TR",
                    "query": word
                ] ,
                encoding: URLEncoding.default)
        case .getSearchedMovies(let word):
            return .requestParameters(
                parameters: [
                    "api_key": apiKey,
                    "language": "tr-TR",
                    "query": word
                    ] ,
                encoding: URLEncoding.default)
        case .getNowPlayingMovies:
            return .requestParameters(
                parameters: [
                    "api_key": apiKey,
                    "language": "tr-TR",
                    "page": "1" ] ,
                encoding: URLEncoding.default)
            
        case .getTopRatedTV:
            return .requestParameters(
                parameters: [
                    "api_key": apiKey,
                    "language": "tr-TR",
                    "page": "1" ] ,
                encoding: URLEncoding.default)
            
        case .getPopularTV:
            return .requestParameters(
                parameters: [
                    "api_key": apiKey,
                    "language": "tr-TR",
                    "page": "1" ] ,
                encoding: URLEncoding.default)
            
            
        case .getSelectedTVDetail( _):
            return .requestParameters(
                parameters: [
                    "api_key": apiKey,
                    "language": "tr-TR" ] ,
                encoding: URLEncoding.default)
            
        case .getSelectedTVVideo( _):
            return .requestParameters(
                parameters: [
                    "api_key": apiKey,
                    "language": "en-US" ] ,
                encoding: URLEncoding.default)
    
        case .getSelectedTVActors( _):
            return .requestParameters(
                parameters: [
                    "api_key": apiKey
                ] ,
                encoding: URLEncoding.default)
        case .getPopularMovies:
            return .requestParameters(
                parameters: [
                    "api_key": apiKey,
                    "language": "tr-TR",
                    "sort_by": "popularity.desc",
                    "include_adult": "false",
                    "include_video": "false" ] ,
                encoding: URLEncoding.default)
            
        case .getSelectedMovie( _):
            return .requestParameters(
                parameters: [
                    "api_key": apiKey,
                    "language": "tr-TR"
                    ] ,
                encoding: URLEncoding.default)
        case .getSelectedActorsImages( _):
            return .requestParameters(
                parameters: [
                    "api_key": apiKey
                    
                ] ,
                encoding: URLEncoding.default)
        case .getSelectedMoviesImages( _):
            return .requestParameters(
                parameters: [
                    "api_key": apiKey
                   
                ] ,
                encoding: URLEncoding.default)
        case .getSelectedActor( _):
            return .requestParameters(
                parameters: [
                    "api_key": apiKey
                    
                     ] ,
                encoding: URLEncoding.default)
            
        case .getSelectedMoviesActors( _):
            return .requestParameters(
                parameters: [
                    "api_key": apiKey,
                    
                ] ,
                encoding: URLEncoding.default)
            
        case .getSelectedMoviesSimilarMovies( _):
            return .requestParameters(
                parameters: [
                    "api_key": apiKey,
                    "language": "tr-TR",
                    "page": "1"
                    ] ,
                encoding: URLEncoding.default)
            
        case .getSelectedMoviesVideo( _):
            return .requestParameters(
                parameters: [
                    "api_key": apiKey,
                    "language": "en-US"
                    
                ] ,
                encoding: URLEncoding.default)
        }
        
        
        
    }
        
    }

