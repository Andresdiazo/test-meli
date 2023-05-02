//
//  ItemSearchTableViewCell.swift
//  TechnicalMeli
//
//  Created by Andres Diaz  on 9/04/23.
//

import UIKit

class ItemSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var shippingMethodLabel: UILabel!
    @IBOutlet weak var priceItemLabel: UILabel!
    @IBOutlet weak var titleItemLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    let aIndicator = UIActivityIndicatorView(style: .large)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        aIndicator.center = center
        addSubview(aIndicator)
        aIndicator.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
