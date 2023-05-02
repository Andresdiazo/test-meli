//
//  SearchItemViewController.swift
//  TechnicalMeli
//
//  Created by Andres Diaz  on 9/03/23.
//

import UIKit

class SearchItemViewController: UIViewController, UISearchControllerDelegate {
    
    
    @IBOutlet weak var searchTableView: UITableView!
    private var searchController = UISearchController(searchResultsController: nil)
    var itemSelected: SearchResultItems?
    var array: [SearchResultItems]?
    var presenter: SearchItemPresenterProtocol = SearchItemPresenter()
    let aIndicator = UIActivityIndicatorView(style: .large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSplashScreen()
        presenter.setDelegate(delegate: self)
//        aIndicator.center = view.center
//        view.addSubview(aIndicator)

//        aIndicator.startAnimating()
        self.searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    
                presenter.searchItem(query: "Auriculares")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        aIndicator.startAnimating()
        searchTableView.register(UINib(nibName: "ItemSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
    }
    
    func navigateToDetailView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "ItemDetailViewController") as! ItemDetailViewController
        detailViewController.itemSelected = self.itemSelected
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    private func showSplashScreen() {
        guard let splashScreen = storyboard?.instantiateViewController(withIdentifier: "SplashScreenViewController") as? SplashScreenViewController else { return }
        addChild(splashScreen)
        splashScreen.view.frame = view.frame
        view.addSubview(splashScreen.view)
        splashScreen.didMove(toParent: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            splashScreen.willMove(toParent: nil)
            splashScreen.view.removeFromSuperview()
            splashScreen.removeFromParent()
        }
    }

}
extension SearchItemViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.array?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? ItemSearchTableViewCell else {
            fatalError("No se pudo obtener la celda personalizada.")
        }
        
        cell.titleItemLabel.text = self.array?[indexPath.row].title
        cell.priceItemLabel.text = GeneralHelper.formatPrice(self.array?[indexPath.row].price ?? 0)
        
        if self.array?[indexPath.row].shipping?.freeShipping ?? false {
            cell.shippingMethodLabel.text = "Envío gratis"
        }
        
        if let urlString = self.array?[indexPath.row].thumbnail as? String {
            ImageHelper.loadImage(from: urlString) { image in
                cell.thumbnailImageView.image = image
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.itemSelected = self.array?[indexPath.row]
        self.navigateToDetailView()
    }
}
extension SearchItemViewController: UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        if let query = searchController.searchBar.text {
            presenter.searchItem(query: query)
        }
    }
}

extension SearchItemViewController: SearchItemPresenterDelegate {
    func getResults(results: [SearchResultItems]?) {
        if let data = results {
            array = data
        }
        DispatchQueue.main.async {
            self.searchTableView.delegate = self
            self.searchTableView.dataSource = self
            self.aIndicator.stopAnimating()
            self.searchTableView.reloadData()
        }
    }
}






