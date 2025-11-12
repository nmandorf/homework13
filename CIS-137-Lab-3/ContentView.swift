/*
 *  Noa Tomas Mandorf
 *  November 11, 2025
 */

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MemoryGameViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text("🎉 Game Completed!")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.blue)
                        .padding(.bottom, 8)

                    ProgressView(value: viewModel.complete, total: 1.0)
                        .tint(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                        .scaleEffect(x: 1, y: 4, anchor: .center)
                        .padding(.horizontal, 40)
                        .animation(.easeInOut(duration: 1.0), value: viewModel.complete)

                    Text("\(Int(viewModel.complete * 100))%")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                }
                Text("Match the flowers")
                    .font(.largeTitle)
                    .bold()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(viewModel.cards) { card in
                            TileView(card: card).aspectRatio(1, contentMode: .fit)
                                .onTapGesture {
                                    withAnimation{
                                        viewModel.choose(card: card)
                                    }
                                }
                    }
                }
            }
        }
        .padding()
    }
}



struct TileView: View {
    var card: MemoryGameModel.Card
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: 75, height: 75)
                .padding()
                .opacity(card.isFaceUp ? 0 : 1)
            Image(card.imageFile)
                .resizable()
                .padding()
                .opacity(card.isFaceUp ? 1 : 0)
        }
        .rotation3DEffect(
                    Angle.degrees(card.isFaceUp ? 0 : 180),
                    axis: (x: 0, y: 1, z: 0)
                )
                .animation(.easeInOut(duration: 0.3), value: card.isFaceUp)
        
    }
}

#Preview {
    ContentView(viewModel: MemoryGameViewModel())
}
