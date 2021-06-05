//
//  ProgressView.swift
//  CoachCarterV2
//
//  Created by Firat Ak on 05.06.21.
//

import SwiftUI
import Charts

/*
    View für Chart mit dummy daten ( fürs erste )
 */
struct ProgressView: View {
    var body: some View {
            VStack {
                Spacer()
                //Y-Achse anzeige
                HStack {
                    VStack(spacing: 45) {
                        Text("250")
                        
                        Text("200")
                        
                        Text("100")
                        
                        Text("50")
                    }
                    
                    //Framework um chart zu generieren
                    Chart(data: [0.8, 0.3, 0.5, 0.1])
                        .chartStyle(
                            StackedColumnChartStyle(spacing: 10, colors: [.blue])
                            
                        )
                        .frame(width: UIScreen.main.bounds.width - 80, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
                //X-Achse anzeige
                HStack(spacing: 37) {
                    Text("WE 1")
                    Text("WE 2")
                    Text("WE 3")
                    Text("WE 4")
                }
                .padding(.leading, 30)
                
                Spacer()

            }
            .navigationBarTitle("Chart 📈")
            .offset(x: 0, y: -60)
        
        
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
