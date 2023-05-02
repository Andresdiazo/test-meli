//
//  SearchItemModel.swift
//  TechnicalMeli
//
//  Created by Andres Diaz  on 9/03/23.
//

import Foundation

struct SearchResult: Decodable {
    let country: String?
    var siteId: String?
    var results: [SearchResultItems]
    
    enum CodingKeys: String, CodingKey {
        case country = "country_default_time_zone"
        case siteId  = "site_id"
        case results
    }
}
struct SearchResultItems: Decodable {
    let id: String?
    let title: String?
    let condition: String?
    let thumbnailId: String?
    let catalogProductId: String?
    let listingTypeId: String?
    let permalink: String?
    let buyingMode: String?
    let siteId: String?
    let categoryId: String?
    let domainId: String?
    let thumbnail: String?
    let currencyId: String?
    let orderBackend: Int?
    let price: Double?
    let originalPrice: Int?
    let salePrice: Int?
    let soldQuantity: Int?
    let availableQuantity: Int?
    let officialStoreId: Int?
    let useThumbnailId: Bool?
    let acceptsMercadoPago: Bool?
    let stopTime: String?
    let shipping: Shipping?
   
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case condition
        case thumbnailId = "thumbnail_id"
        case catalogProductId = "catalog_product_id"
        case listingTypeId = "listing_type_id"
        case permalink
        case buyingMode = "buying_mode"
        case siteId = "site_id"
        case categoryId = "category_id"
        case domainId = "domain_id"
        case thumbnail
        case currencyId = "currency_id"
        case orderBackend = "order_backend"
        case price
        case originalPrice = "original_price"
        case salePrice = "sale_price"
        case soldQuantity = "sold_quantity"
        case availableQuantity = "available_quantity"
        case officialStoreId = "official_store_id"
        case useThumbnailId = "use_thumbnail_id"
        case acceptsMercadoPago = "accepts_mercadopago"
        case stopTime = "stop_time"
        case shipping
    }
}
struct Shipping: Decodable {
    let storePickUp: Bool?
    let freeShipping: Bool?
    
    enum CodingKeys: String, CodingKey {
        case storePickUp = "store_pick_up"
        case freeShipping = "free_shipping"
    }
}
