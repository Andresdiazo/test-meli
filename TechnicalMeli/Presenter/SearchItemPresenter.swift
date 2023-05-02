//
//  SearchItemPresenter.swift
//  TechnicalMeli
//
//  Created by Andres Diaz  on 18/04/23.
//

import Foundation

protocol SearchItemPresenterDelegate: NSObject {
    func getResults(results: [SearchResultItems]?)
}

protocol SearchItemPresenterProtocol {
    func searchItem(query: String)
    func setDelegate(delegate: SearchItemPresenterDelegate)
}

class SearchItemPresenter {
    weak var delegate: SearchItemPresenterDelegate!
    let baseURL = "https://api.mercadolibre.com/sites/MCO"
    func setDelegate(delegate: SearchItemPresenterDelegate) {
        self.delegate = delegate
    }
}
extension SearchItemPresenter: SearchItemPresenterProtocol {
    func searchItem(query: String) {
        let networkService = NetworkService(baseURL: baseURL)
        let params = ["q" : query]
        networkService.fecthData(path: "/search", params: params) { (result: Result<SearchResult, Error>) in
            switch result {
            case .success(let search):
                if !search.results.isEmpty && self.delegate != nil {
                    self.delegate.getResults(results: search.results)
                } else {
                    
                }
            case .failure(_):
                print("Hubo un error en la busqueda")
            }
        }
    }
}
