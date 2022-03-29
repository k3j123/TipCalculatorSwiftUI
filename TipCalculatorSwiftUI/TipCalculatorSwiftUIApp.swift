import SwiftUI

@main
struct TipCalculatorSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            TipCalculatorView(viewModel: TipCalculatorViewModel())
        }
    }
}
