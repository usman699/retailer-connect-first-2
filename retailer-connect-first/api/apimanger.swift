import Foundation
import Alamofire
enum APIError: Error {
    case decodingError
    case notFound
    case conflict
    case unknownError
    case unresponseEntity
    case outofstack

}

public func performRequest<T: Decodable>(url: String, method: HTTPMethod, responseType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
    let headers: HTTPHeaders = [.authorization(bearerToken: Globaltoken)]
    AF.request(url, method: method, headers: headers)
        .validate(statusCode: 200..<300) // Ensure response status code is in the success range
        .responseData { response in
            print("stataus code ",response.response?.statusCode)
       
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let responseObject = try decoder.decode(T.self, from: data)
                    print(responseObject)
                    completion(.success(responseObject))
                } catch {
                    print("Error decoding response:", error)
                    completion(.failure(.decodingError))
                }
            case .failure(let error):
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 404:
                        completion(.failure(.notFound))
                    case 409:
                        completion(.failure(.conflict))
                    case 422:
                        completion(.failure(.unresponseEntity))
                    case 400:
                        completion(.failure(.outofstack))
                    default:
                        completion(.failure(.unknownError))
                    }
                } else {
                    completion(.failure(.unknownError))
                }
            }
        }
}
