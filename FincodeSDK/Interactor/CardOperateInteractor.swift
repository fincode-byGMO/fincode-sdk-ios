//
//  CardOperateInteractor.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/21.
//

import Foundation

protocol CardInfoListDelegate: AnyObject {
    func success(_ result: FincodeCardInfoListResponse)
}

protocol CardOperateInteractorDelegate: AnyObject {
    var delegate: ResultDelegate? { get set }
    var cardInfoListDelegate: CardInfoListDelegate? { get set }
    func cardInfoList(_ customerId: String, header: [String: String])
    func registerCard(_ customerId: String, request: FincodeCardRegisterRequest, header: [String: String])
    func updateCard(_ customerId: String, cardId: String , request: FincodeCardUpdateRequest, header: [String: String])
}

class CardOperateInteractor {
 
    private let cardUseCase = CardOperateUseCase()
    weak var delegate: ResultDelegate?
    weak var cardInfoListDelegate: CardInfoListDelegate?
    
    init() {
        self.cardUseCase.delegate = self
    }
    
}

extension CardOperateInteractor: CardOperateInteractorDelegate {
    
    func cardInfoList(_ customerId: String, header: [String: String]) {
        cardUseCase.cardInfoList(customerId, header: header)
    }
    
    func registerCard(_ customerId: String, request: FincodeCardRegisterRequest, header: [String : String]) {
        cardUseCase.registerCard(customerId, request:request, header: header)
    }
    
    func updateCard(_ customerId: String, cardId: String, request: FincodeCardUpdateRequest, header: [String : String]) {
        cardUseCase.updateCard(customerId, cardId: cardId, request:request, header: header)
    }
}

extension CardOperateInteractor: CardUseCaseDelegate {

    func CardUseCase(_ useCase: CardOperateUseCase, response: FincodeCardInfoListResponse) {
        cardInfoListDelegate?.success(response)
    }
    
    func CardUseCase(_ useCase: CardOperateUseCase, response: FincodeCardRegisterResponse) {
        delegate?.success(response)
    }

    func CardUseCase(_ useCase: CardOperateUseCase, response: FincodeCardUpdateResponse) {
        delegate?.success(response)
    }
    
    func CardUseCaseFaild(_ useCase: CardOperateUseCase, withError error: APIError) {
        // TODO API失敗の実装をする
        delegate?.failure()
    }
}
