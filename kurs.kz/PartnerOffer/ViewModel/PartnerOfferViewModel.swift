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
            
        }
    }
    
    private var sentOffers: [AcceptedSentOfferResponse] = [] {
        didSet {
            print("hereeeeeeess2 \(sentOffers.count)")
        }
    }
    private var offerRequests: [AcceptedSentOfferResponse] = [] {
        didSet {
        }
    }
    
    // MARK: - Modal Screen
    
    private lazy var modalScreen: ChangeExchangeRateViewController = {
        let controller = ChangeExchangeRateViewController()
        controller.delegate = self
        return controller
    }()
    
    // MARK: - Initializer
    init(view: PartnerOfferView, service: PartnerOfferService) {
        self.view = view
        self.service = service
    }
    
    // MARK: - Action
    private func showAlert() {
        let alert = UIAlertController(title: "Ошибка!",
                                      message: "Попробуйте позднее",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        let vc = view as? PartnerOfferViewController
        vc?.present(alert, animated: true, completion: nil)
    }
    
    private func getAcceptedOffers(completion: @escaping () -> Void) {
        service.fetchAcceptedOffers { [weak self] result in
            switch result {
            case .success(let result):
                self?.acceptedOffers = result
                print("accepted is \(result)")
                completion()
            case .failure:
                print("error getting accepted offers")
            }
        }
    }

    private func getSentOffers(completion: @escaping () -> Void) {
        service.fetchSentOffers { [weak self] result in
            switch result {
            case .success(let result):
                self?.sentOffers = result
                print("sent is \(result)")
                completion()
            case .failure:
                print("error getting sent offers")
            }
        }
    }

    private func getOfferRequests(completion: @escaping () -> Void) {
        service.fetchOfferRequests { [weak self] result in
            switch result {
            case .success(let result):
                self?.offerRequests = result
                print("requests are \(result)")
                completion()
            case .failure:
                print("error getting requests")
            }
        }
    }

    public func updateOffers() {
        print("here2323223")
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        
        getAcceptedOffers {
            print("leaving 1")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getSentOffers {
            print("leaving 2")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getOfferRequests {
            print("leaving 3")

            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            // All tasks have finished
            print("finished!!!")
            self.view?.reloadTable()
        }
    }

    public func configureCell(with cell: ApplicationTableViewCell, at index: Int) {
        let item = offerRequests[index]
        cell.configureCell(with: item)
        cell.selectionStyle = .none
        cell.acceptButtonAction = { [weak self] in
            if let exchangeRate = item.exchangeRate, let offerId = item.offerId {
                self?.service.replyToOffer(exchangeRate: exchangeRate,
                                           hasAccepted: true,
                                           offerId: offerId,
                                           completion: { [weak self] result in
                    switch result {
                    case .success(let result):
                        print("has accepted: \(result)")
                        self?.updateOffers()
                    case .failure:
                        self?.showAlert()
                    }
                })
            } else { self?.showAlert() }
        }
        
        cell.cancelButtonAction = { [weak self] in
            if let exchangeRate = item.exchangeRate, let offerId = item.offerId {
                self?.service.replyToOffer(exchangeRate: exchangeRate,
                                           hasAccepted: false,
                                           offerId: offerId,
                                           completion: { [weak self] result in
                    switch result {
                    case .success(let result):
                        print("has declined: \(result)")
                        self?.updateOffers()
                    case .failure:
                        self?.showAlert()
                        print("error declining the offer")
                    }
                })
            } else {
                self?.showAlert()
            }
        }
        
        cell.offerYourCurrencyButtonAction = { [weak self] in
            if let exchangeRate = item.exchangeRate,
               let unwrappedScreen = self?.modalScreen,
               let offerId = item.offerId {
                unwrappedScreen.setExchangeRate(rate: exchangeRate)
                unwrappedScreen.setOfferId(id: offerId)
                let vc = self?.view as? PartnerOfferViewController
                vc?.presentPanModal(unwrappedScreen)
            } else {
                self?.showAlert()
            }
        }
    }
    
    public func configureRequestsHeader(with header: ApplicationsHeaderView) {
        header.setupRequestsHeaderCounter(with: offerRequests.count)
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
    public func retrieveAcceptedOffers() -> [AcceptedSentOfferResponse] {
        acceptedOffers
    }
    public func retrieveSentOffers() -> [AcceptedSentOfferResponse] {
        sentOffers
    }
}

    // MARK: - Protocol
protocol PartnerOfferView: AnyObject {
    func reloadTable()
}

protocol AcceptedSentTableCellProtocol: UITableViewCell {
    func setupCell(with count: Int, type: PartnerOfferType )
}

enum PartnerOfferType {
    case accepted
    case sent
}
    // MARK: - Extension: ChangeExchangeRateViewControllerDelegate
extension PartnerOfferViewModel: ChangeExchangeRateViewControllerDelegate {
    func saveChanges() {
          if let offerId = modalScreen.getOfferId() {
            service.replyToOffer(exchangeRate: modalScreen.getExchangeRate(),
                                 hasAccepted: true,
                                 offerId: offerId,
                                 completion: { [weak self] result in
                switch result {
                case .success(let result):
                    print("has accepted: \(result)")
                    self?.updateOffers()
                case .failure:
                    self?.showAlert()
                    print("error accepting the offer")
                }
            })
          } else {
              self.showAlert()
          }
    }
}
