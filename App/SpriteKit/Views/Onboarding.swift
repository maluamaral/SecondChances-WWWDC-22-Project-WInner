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
                VStack{
                    Text("Malu Amaral")
                        .font(.custom("Poppins-Regular", size: 36))
                        .foregroundColor(Color("black"))
                    Text("Second Chances")
                        .font(.custom("Koulen-Regular", size: 96))
                        .foregroundColor(Color("black"))
                }
                Image("capa")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth - 125, height: screenHeight - 300, alignment: .center)
                
            }//.padding(.top, 200)
            
            NavigationLink(destination: Apresentation()){
                ZStack(){
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 356, height: 85)
                        .foregroundColor(Color("brown"))
                        .cornerRadius(14)
                    Text("START")
                        .font(.system(size: 36, weight: .medium, design: .default))
                        .foregroundColor(Color("creme"))
                    
                } .padding(.top, UIScreen.main.bounds.size.height * 0.8)
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
