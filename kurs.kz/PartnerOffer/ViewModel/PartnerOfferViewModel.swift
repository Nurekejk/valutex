//
//  PartnerOfferViewModel.swift
//  kurs.kz
//
//  Created by MacBook on 06.10.2023.
//

import Foundation
import UIKit

final class PartnerOfferViewModel {
    
    // MARK: - Properties
    private weak var view: PartnerOfferView?
    private let service: PartnerOfferService
    
    private var acceptedOffers: [AcceptedSentOfferResponse] = [] {
        didSet {
            print("hereeeeeeess \(acceptedOffers.count)")
                view?.reloadTable()
        }
    }
    
    private var sentOffers: [AcceptedSentOfferResponse] = [] {
        didSet {
            print("hereeeeeeess2 \(sentOffers.count)")
                view?.reloadTable()
        }
    }
    private var offerRequests: [AcceptedSentOfferResponse] = [] {
        didSet {
            if oldValue.count != offerRequests.count {
                view?.updateRequestsCount(requestsCount: offerRequests.count)
            }
        }
    }

    // MARK: - Initializer
    init(view: PartnerOfferView, service: PartnerOfferService) {
        self.view = view
        self.service = service
    }
    
    // MARK: - Action
    private func getAcceptedOffers() {
        service.fetchAcceptedOffers(completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.acceptedOffers = result
                print("accepted isss \(result)")
            case .failure:
                print("error getting accepted offers")
            }
        })
    }
    
    private func getSentOffers() {
        service.fetchSentOffers(completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.sentOffers = result
                print("sent isss \(result)")
            case .failure:
                print("error getting sent offers")
            }
        })
    }
    
    private func getOfferRequests() {
        service.fetchOfferRequests(completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.offerRequests = result
                print("requests are \(result)")
            case .failure:
                print("error getting requests")
            }
        })
    }
    
    public func updateOffers() {
        getAcceptedOffers()
        getSentOffers()
        getOfferRequests()
    }
    
    public func configureCell(with cell: ApplicationTableViewCell, at index: Int) {
        let item = offerRequests[index]
        cell.selectionStyle = .none
        let vc = view as? PartnerOfferViewController
        cell.acceptButtonAction = { [weak self] in
              let alert = UIAlertController(title: "Принято!",
                                            message: "Вы успешно приняли запрос.",
                                            preferredStyle: .alert)
              let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              alert.addAction(okAction)
                
            vc?.present(alert, animated: true, completion: nil)
        }
        
        cell.cancelButtonAction = { [weak self] in
              let alert = UIAlertController(title: "Отменено!",
                                            message: "Вы отменили запрос.",
                                            preferredStyle: .alert)
              let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              alert.addAction(okAction)
                    
            vc?.present(alert, animated: true, completion: nil)
        }
        
        cell.offerYourCurrencyButtonAction = { [weak self] in
              let alert = UIAlertController(title: "Вы предложили свой курс!",
                                            message: "",
                                            preferredStyle: .alert)
              let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              alert.addAction(okAction)
                    
            vc?.present(alert, animated: true, completion: nil)
        }
//        cell.textLabel?.text = item.title
//        cell.detailTextLabel?.text = item.description
    }
    public func configureRequestsHeader(with header: ApplicationsHeaderView) {
        header.setupHeaderCounter(with: offerRequests.count)
    }
    
    public func getNumberOfRequests() -> Int {
        offerRequests.count
    }
    
    public func configureAcceptedSentCell(with cell: AcceptedSentTableCellProtocol, indexPath: IndexPath) {
        cell.selectionStyle = .none
        if indexPath.section == 0 {
            cell.setupCell(with: acceptedOffers.count, type: .accepted)
        
        } else if indexPath.section == 1 {
            cell.setupCell(with: sentOffers.count, type: .sent)
        }
    }
}

    // MARK: - Protocol
protocol PartnerOfferView: AnyObject {
    func updateAcceptedCount(acceptedCount: Int)
    func updateSentCount(sentCount: Int)
    func updateRequestsCount(requestsCount: Int)
    func reloadTable()
}

protocol AcceptedSentTableCellProtocol: UITableViewCell {
    func setupCell(with count: Int, type: PartnerOfferCellType )
}

enum PartnerOfferCellType {
    case accepted
    case sent
}
