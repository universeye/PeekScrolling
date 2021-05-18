//
//  ContentView.swift
//  PeekScrolling
//
//  Created by Terry Kuo on 2021/2/17.
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 0.9490196078, green: 0.9647058824, blue: 1, alpha: 1))
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Text("Courses")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 30)//default value is 16
                    
                    ForEach(0 ..< 4) { item in
                        GeometryReader { geometry in
                            cardView(minY: geometry.frame(in: .global).minY)
                            Text("\(geometry.frame(in: .global).minY)")
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 440)
                    }
                    //Spacer() //use all the space
                }
            }
        } //ZStck
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct cardView: View {
    @State var show = false
    var minY: CGFloat
    
    var body: some View {
        ZStack {
            Image("Item")
                .shadow(color:Color(#colorLiteral(red: 0.1794841265, green: 0.1794841265, blue: 0.1794841265, alpha: 0.191504169)), radius: 40, x: 0, y: 20)
                .offset(x: show ? 10 : 80)
                //.rotation3DEffect(
                // Angle(degrees: show ? 0 : 30),
                // axis: (x: 0,  y: 10, z:0))
                .animation(Animation.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0).delay(0.2))
            
            
            Image("Card1")
                .shadow(color:Color(#colorLiteral(red: 0.1794841265, green: 0.1794841265, blue: 0.1794841265, alpha: 0.191504169)), radius: 40, x: 0, y: show ? 100 : 20)
                .offset(x: show ? -300 : 0)
                .animation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0))
        }
        .scaleEffect(minY<0 ? minY / 1000 + 1 : 1, anchor: .bottom) //when minY<0 stars the scaling
        .rotation3DEffect(
            Angle(degrees: 10),
            axis: (x: -10.0, y: 0.0, z: 0.0)
        )
        .onTapGesture {
            self.show.toggle()
        }
    }
}
