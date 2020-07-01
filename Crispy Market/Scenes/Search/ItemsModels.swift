//
//  ItemsModel.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

enum Items {
    // MARK: Use cases
    
    enum FetchItems {
        struct Request {
            let countryID: String?
            let query: String
        }

        // MARK: - Items
        struct Response: Codable {
            let paging: Paging
            let results: [ViewModel]
            let siteID: String
            
            enum CodingKeys: String, CodingKey {
                case paging, results
                case siteID = "site_id"
            }
        }
        
        // MARK: - SimpleItem
        struct SimpleViewModel: Codable {
            let id, title: String?
            let seller: Seller?
            let price: Float?
            let currencyID: String?
            let availableQuantity, soldQuantity: Int?
            let buyingMode: String?
            let thumbnail: String?
            let acceptsMercadopago: Bool?
            let installments: Installments?
            let address: Address?
            let shipping: Shipping?
            let attributes: [Attribute]?
            let originalPrice: Float?
            let categoryID: String?
        }
        
        // MARK: - Item
        struct ViewModel: Codable {
            let id, siteID, title: String?
            let seller: Seller?
            let price: Float?
            let currencyID: String?
            let availableQuantity, soldQuantity: Int?
            let buyingMode, listingTypeID, stopTime, condition: String?
            let permalink: String?
            let thumbnail: String?
            let acceptsMercadopago: Bool?
            let installments: Installments?
            let address: Address?
            let shipping: Shipping?
            let sellerAddress: SellerAddress?
            let attributes: [Attribute]?
            let originalPrice: Float?
            let categoryID: String?
            let tags: [String]?
            
            enum CodingKeys: String, CodingKey {
                case attributes, condition, permalink, thumbnail, tags, id, installments, address, shipping, title, seller, price
                case siteID = "site_id"
                case currencyID = "currency_id"
                case availableQuantity = "available_quantity"
                case soldQuantity = "sold_quantity"
                case buyingMode = "buying_mode"
                case listingTypeID = "listing_type_id"
                case stopTime = "stop_time"
                case acceptsMercadopago = "accepts_mercadopago"
                case sellerAddress = "seller_address"
                case originalPrice = "original_price"
                case categoryID = "category_id"
            }
        }
    }
    
    // MARK: - City
    struct City: Codable {
        let id, name: String?
    }
    
    // MARK: - Address
    struct Address: Codable {
        let stateID, stateName, cityID, cityName: String?
        
        enum CodingKeys: String, CodingKey {
            case stateID = "state_id"
            case stateName = "state_name"
            case cityID = "city_id"
            case cityName = "city_name"
        }
    }
    
    // MARK: - Attribute
    struct Attribute: Codable {
        let id: String?
        let values: [Value]?
        let attributeGroupID, attributeGroupName, name, valueID, valueName: String?
        let source: Int?
        
        enum CodingKeys: String, CodingKey {
            case id, name, source, values
            case attributeGroupID = "attribute_group_id"
            case attributeGroupName = "attribute_group_name"
            case valueID = "value_id"
            case valueName = "value_name"
        }
    }
    
    // MARK: - DifferentialPricing
    struct DifferentialPricing: Codable {
        let id: Int?
    }
    
    // MARK: - Installments
    struct Installments: Codable {
        let amount: Double?
        let currencyID: String?
        let quantity: Int?
        let rate: Float?
        
        enum CodingKeys: String, CodingKey {
            case amount, quantity, rate
            case currencyID = "currency_id"
        }
    }
    
    // MARK: - Paging
    struct Paging: Codable {
        let total, offset, limit, primaryResults: Int
        
        enum CodingKeys: String, CodingKey {
            case total, offset, limit
            case primaryResults = "primary_results"
        }
    }
    
    // MARK: - Seller
    struct Seller: Codable {
        let id: Int?
        let carDealer, realEstateAgency: Bool
        let tags: [String]?
        
        enum CodingKeys: String, CodingKey {
            case id, tags
            case carDealer = "car_dealer"
            case realEstateAgency = "real_estate_agency"
        }
    }
    
    // MARK: - SellerAddress
    struct SellerAddress: Codable {
        let id, comment, addressLine, zipCode: String?
        let country, state, city: City?
        let latitude, longitude: String?
        
        enum CodingKeys: String, CodingKey {
            case comment, country, city, id, latitude, longitude, state
            case addressLine = "address_line"
            case zipCode = "zip_code"
        }
    }
    
    // MARK: - Shipping
    struct Shipping: Codable {
        let freeShipping: Bool
        let mode: String?
        let tags: [String]?
        let logisticType: String?
        let storePickUp: Bool?
        
        enum CodingKeys: String, CodingKey {
            case freeShipping = "free_shipping"
            case mode, tags
            case logisticType = "logistic_type"
            case storePickUp = "store_pick_up"
        }
    }
    
    // MARK: - Value
    struct Value: Codable {
        let id, name: String?
        let source: Int?
    }
}
