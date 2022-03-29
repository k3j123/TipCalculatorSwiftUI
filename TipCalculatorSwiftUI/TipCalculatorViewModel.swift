import Foundation
import Combine

class TipCalculatorViewModel: ObservableObject {
    
    @Published var tip: NSDecimalNumber?
    @Published var tipPerGuest: NSDecimalNumber?
    @Published var totalAmount: NSDecimalNumber?
    
    @Published var principleAmount: Decimal?
    @Published var guests = 2
    @Published var selectedTipIndex = 0
    
    let baseTipPercentages = [15, 20, 25]
    
    private var cancellable: Set<AnyCancellable> = []
    
    init() {
        $principleAmount
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.calculateTip()
            })
            .store(in: &cancellable)
    
        $guests
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.calculateTip()
            })
            .store(in: &cancellable)
        
        $selectedTipIndex
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.calculateTip()
            })
            .store(in: &cancellable)
    }
    
    var tipPercentage: Int = 0
    
    func calculateTip() {
        guard let amount = principleAmount else {
            return
        }
        
        let tipPercentage = (Double(baseTipPercentages[selectedTipIndex]) / 100 ) * NSDecimalNumber(decimal: amount).doubleValue
        tip = NSDecimalNumber(value: tipPercentage)
        tipPerGuest = NSDecimalNumber(value: tipPercentage / Double(guests))
        totalAmount = NSDecimalNumber(decimal: amount).adding(tip!)
    }
}
