import SwiftUI

struct TipCalculatorView: View {
    @ObservedObject var viewModel: TipCalculatorViewModel
    init (viewModel: TipCalculatorViewModel) {
        self.viewModel = viewModel
    }
    
    private var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var body: some View {
        Form {
            Text("Tip calculator")
                .font(.title)
                .fontWeight(.bold)
            Section(header: Text("Enter Your Meal Information"), content: {
                Stepper(
                    "Guests: \(viewModel.guests.description)",
                    value: $viewModel.guests,
                    in: 1...16
                )
                CurrencyField(
                    "Enter meal cost",
                    value: Binding(get: {
                        viewModel.principleAmount.map { NSDecimalNumber(decimal: $0) }
                    }, set: { number in
                        viewModel.principleAmount = number?.decimalValue
                    })
                )
            })
            Section(header: Text("Select Tip Percentage"), content: {
                Picker("Select", selection: $viewModel.selectedTipIndex) {
                    ForEach(0..<3) { value in
                        Text(viewModel.baseTipPercentages[value].description).tag(value)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            })
            Section(header: Text("To Pay:"), content: {
                Text("Total Tip to Pay \(currencyFormatter.string(from: viewModel.tip ?? 0) ?? "0")")
                Text("Tip Per Guest \(currencyFormatter.string(from: viewModel.tipPerGuest ?? 0) ?? "0")")
                Text("Total to Pay \(currencyFormatter.string(from: viewModel.totalAmount ?? 0) ?? "0")")
            })
        }
    }
}

struct TipCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        TipCalculatorView(viewModel: TipCalculatorViewModel())
    }
}
