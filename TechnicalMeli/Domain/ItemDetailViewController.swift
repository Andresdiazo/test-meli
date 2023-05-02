//
//  ItemDetailViewController.swift
//  TechnicalMeli
//
//  Created by Andres Diaz  on 3/04/23.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    @IBOutlet weak var titleItemLabel: UILabel!
    @IBOutlet weak var itemsSelectedImageView: UIImageView!
    @IBOutlet weak var priceIitemLB: UILabel!
    var itemSelected: SearchResultItems?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemsSelectedImageView.loadFrom(URLAddres: self.itemSelected?.thumbnail ?? "")
        self.titleItemLabel.text = self.itemSelected?.title
        let priceNumber = NSNumber(value: self.itemSelected?.price ?? 0)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 0
        let formattedPrice = formatter.string(from: priceNumber)
        self.priceIitemLB.text = formattedPrice
        //        self.descriptionItemText.text = self.itemSelected?.id
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
extension UIImageView {
    func loadFrom(URLAddres: String) {
        guard let url = URL(string: URLAddres) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
        .resume()
    }
}




