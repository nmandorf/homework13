/*
 *  Lab 3
 *  Group 9
 *  Noa Tomas Mandorf
 *  Tyler Hager
 *  November 10, 2025
 */

import SwiftUI

@main
struct CIS_137_Lab3App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: MemoryGameViewModel())
        }
    }
}
