//
//  CardOperateInteractor.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/21.
//

import Foundation

protocol CardOperateInteractorDelegate: AnyObject {
    var delegate: ResultDelegate? { get set }
    func cardInfoList(_ customerId: String, header: [String: String])
}

class CardOperateInteractor {
 
    private let cardUseCase = CardOperateUseCase()
    weak var delegate: ResultDelegate?
    
    init() {
        self.cardUseCase.delegate = self
    }
    
}

extension CardOperateInteractor: CardOperateInteractorDelegate {
    
    func cardInfoList(_ customerId: String, header: [String: String]) {
        cardUseCase.cardInfoList(customerId, header: header)
    }
}

extension CardOperateInteractor: CardUseCaseDelegate {

    func CardUseCase(_ useCase: CardOperateUseCase, response: CardInfoListResponse) {
        // TODO API成功の実装をする
        delegate?.success(response)
    }

    func CardUseCaseFaild(_ useCase: CardOperateUseCase, withError error: APIError) {
        // TODO API失敗の実装をする
        delegate?.failure()
    }
}
