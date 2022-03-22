//
//  CardOperateInteractor.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/21.
//

import Foundation

protocol CardOperateInteractorDelegate: AnyObject {
    // PresenterからInteractorに委譲する処理を定義
    func cardInfoList(_ customerId: String, header: [String: String])
    func registerCard(_ customerId: String, request: FincodeCardRegisterRequest, header: [String: String])
    func updateCard(_ customerId: String, cardId: String , request: FincodeCardUpdateRequest, header: [String: String])
    // InteractorからPresenterに通知する際のインスタンスを保持
    var presenterNotify: CardOperateInteractorNotify! { get set }
}

protocol CardOperateInteractorNotify: AnyObject {
    // InteractorからPresenterに通知する処理を定義
    func cardInfoListSuccess(_ result: FincodeCardInfoListResponse)
    func cardRegisterSuccess(_ result: FincodeResult)
    func cardUpdateSuccess(_ result: FincodeResult)
    func cardOperateFailure(_ useCase: CardOperateUseCase, withError error: APIError)
}

class CardOperateInteractor {
 
    private let cardUseCase = CardOperateUseCase()
    weak var presenterNotify: CardOperateInteractorNotify!
    
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
        presenterNotify?.cardInfoListSuccess(response)
    }
    
    func CardUseCase(_ useCase: CardOperateUseCase, response: FincodeCardRegisterResponse) {
        presenterNotify?.cardRegisterSuccess(response)
    }

    func CardUseCase(_ useCase: CardOperateUseCase, response: FincodeCardUpdateResponse) {
        presenterNotify?.cardUpdateSuccess(response)
    }
    
    func CardUseCaseFaild(_ useCase: CardOperateUseCase, withError error: APIError) {
        presenterNotify?.cardOperateFailure(useCase, withError: error)
    }
}
