
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class NetworkService {
    
    private var baseURL: URL?
    private let session = URLSession.shared
    
    init(baseURL: String) {
        self.baseURL = URL(string: baseURL)
    }
    
    private func getBaseUrl(path: String, parameters: [String: Any] = [:]) -> URL? {
        guard let baseURL = baseURL?.appendingPathComponent(path) else { return nil }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        if !parameters.isEmpty {
            urlComponents.queryItems = parameters.map {
                URLQueryItem(name: $0, value: String(describing: $1))
            }
        }
        
        let url = URL(string: urlComponents.url?.absoluteString.removingPercentEncoding ?? "")
        
        return url
    }
    
    
    func fecthData<T: Decodable>(htttpMethod: HTTPMethod = .get,
                                 path: String,
                                 params: [String: Any]? = nil,
                                 completionHandler: @escaping (Result<T, Error>) -> Void) {
        var url: URL?
        var httpBody: Data?
        
        if let params = params {
            if htttpMethod != .get {
                let body = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                httpBody = body
                url = self.getBaseUrl(path: path)
            } else {
                url = self.getBaseUrl(path: path, parameters: params)
            }
        } else {
            url = getBaseUrl(path: path)
        }
        
        guard let requestUrl: URL = url else { return }
        
        var request = URLRequest(url: requestUrl)
        request.httpBody = httpBody
        request.httpMethod = htttpMethod.rawValue
        
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                let responseData = try? JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(responseData!))
            } else if let error = error {
                print("Error: \(error)")
                completionHandler(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Respuesta inválida del servidor")
                return
            }
        }
        task.resume()
    }
}


