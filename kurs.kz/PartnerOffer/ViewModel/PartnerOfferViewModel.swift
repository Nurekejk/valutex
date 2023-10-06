//
//  PartnerOfferViewModel.swift
//  kurs.kz
//
//  Created by MacBook on 06.10.2023.
//

import Foundation

final class PartnerOfferViewModel {
    
    // MARK: - Properties
    private weak var view: PartnerOfferView?
    private let service: PartnerOfferService
    
    private var acceptedOffers: [AcceptedSentOfferResponse] = [] {
        didSet {
            view?.updateCounters(acceptedCount: acceptedOffers.count, sentCount: sentOffers.count)
        }
    }
    private var sentOffers: [AcceptedSentOfferResponse] = [] {
        didSet {
            view?.updateCounters(acceptedCount: acceptedOffers.count, sentCount: sentOffers.count)
        }
    }

    // MARK: - Initializer
    init(view: PartnerOfferView, service: PartnerOfferService) {
        self.view = view
        self.service = service
    }
    

    
}

protocol PartnerOfferView: AnyObject {
    func updateCounters(acceptedCount: Int, sentCount: Int)
    func updateOffers()
    
}
