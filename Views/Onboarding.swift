import SwiftUI
import UIKit

struct Onboarding: View {
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight  = UIScreen.main.bounds.size.height
    
    @State var shouldShowAlert = false
    
    var body: some View {
        ZStack{
            Color("creme")
                .ignoresSafeArea()
            VStack(alignment: .leading){
                Text("Malu Amaral")
                    .font(.custom("Poppins-Regular", size: 36))
                    .foregroundColor(Color("black"))
                Text("Second Chances")
                    .font(.custom("Koulen-Regular", size: 96))
                    .foregroundColor(Color("black"))
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: screenWidth - 100, height: screenHeight - 400, alignment: .center)
                    .padding(.bottom, 300)
            }
            .padding(.top, 200)
            
            NavigationLink(destination: Apresentation()){
                ZStack(){
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 356, height: 85)
                        .foregroundColor(Color("brown"))
                        .cornerRadius(14)
                    Text("START")
                        .font(.system(size: 36, weight: .medium, design: .default))
                        .foregroundColor(Color("creme"))
                    
                }
                .padding(.top, 700)
            }
            
            Image("tissue")
                .resizable()
            //.scaledToFill()
                .disabled(true)
                .allowsHitTesting(false)
            //
            if shouldShowAlert {
                AlertLandscape()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didChangeStatusBarOrientationNotification), perform: { _ in
            shouldShowAlert = UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height
        })
        .edgesIgnoringSafeArea(.all)
    }
}

struct Onbording_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
