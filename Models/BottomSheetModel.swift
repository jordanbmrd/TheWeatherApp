import SwiftUI

struct BottomSheetModal<Content: View>: View {
    
    @State var forecastViewModel: ForecastViewModel
    
    private let modalHeight: CGFloat = UIScreen.main.bounds.height - 70
    private let modalWidth: CGFloat = UIScreen.main.bounds.width
    private let modalCornerRadius: CGFloat = 15
    private let backgroundOpacity = 0.65
    private let dragIndicatorVerticalPadding: CGFloat = 2
    
    @State private var offset = CGSize.zero
    @Binding var display: Bool
    
    var content: () -> Content
    
    var body: some View {
        ZStack(alignment: .top){
        	ZStack(alignment: .bottom) {
            	if display {
                	background
                	modal
            	}
        	}
        	.edgesIgnoringSafeArea(.all)
            
            if display {
                date
            }
        }
    }
    
    private var date: some View {
        HStack(){
            Text("📍 \(self.forecastViewModel.currentCity), \(self.forecastViewModel.currentCountry)")
                .foregroundColor(Color.white)
        }
        .padding(.top, 15)
    }
    
    private var background: some View {
        Color.black
            .fillParent()
            .opacity(backgroundOpacity)
            .animation(.spring())
            .gesture(
                DragGesture()
                    .onChanged { value in self.onChangedDragValueGesture(value) }
                    .onEnded { value in self.onEndedDragValueGesture(value) }
        )
    }
    
    private var modal: some View {
        VStack {
            indicator
            self.content()
        }
        .frame(width: modalWidth, height: modalHeight, alignment: .top)
        .background(Color.white)
        .cornerRadius(modalCornerRadius)
        .offset(y: offset.height)
        .transition(.move(edge: .bottom))
        .gesture(
            DragGesture()
                .onChanged { value in self.onChangedDragValueGesture(value) }
                .onEnded { value in self.onEndedDragValueGesture(value) }
        )
    }
    
    private var indicator: some View {
        DragIndicator()
            .padding(.vertical, dragIndicatorVerticalPadding)
    }
    
    private func onChangedDragValueGesture(_ value: DragGesture.Value) {
        guard value.translation.height > 0 else { return }
        self.offset = value.translation
    }
    
    private func onEndedDragValueGesture(_ value: DragGesture.Value) {
        print(value.translation.height)
        guard value.translation.height >= 250 else {
            self.offset = CGSize.zero
            return
        }
        
        withAnimation {
            self.display.toggle()
            self.offset = CGSize.zero
        }
    }
}

struct DragIndicator: View {
    private let width: CGFloat = 60
    private let height: CGFloat = 7
    private let cornerRadius: CGFloat = 3
    
    var body: some View {
        Rectangle()
            .fill(hexColor(0xd2d7d3))
            .frame(width: width, height: height)
            .cornerRadius(cornerRadius)
            .padding(.top, 6)
    }
}

public extension View {
    func fillParent(alignment: Alignment = .center) -> some View {
        self
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: alignment
        )
    }
}
