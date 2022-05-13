//
//  Summary.swift
//  NutriPal
//
//  Created by Jessie Pao on 4/30/22.
//  
//  Followed this tutorial for pie chart
//  https://betterprogramming.pub/build-animated-pie-and-donut-charts-in-swiftui-9b74b95f8b39

import SwiftUI

// Struct to hold the data from the pie chart
struct ChartData {
    var id = UUID()
    var title: String
    var color : Color
    var percent : CGFloat
    var value : CGFloat
    
}

// Class for the chart color and to calculate how much each section the
class ChartDataContainer : ObservableObject {
    @Published var chartData =
    [ChartData(title: "Fat", color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), percent: 25, value: 0),
     ChartData(title: "Carbs",color: Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)), percent: 35, value: 0),
     ChartData(title: "Protein",color: Color(#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)), percent: 40, value: 0)]
    
    func calc(){
        var value : CGFloat = 0
        
        for i in 0..<chartData.count {
            value += chartData[i].percent
            chartData[i].value = value
        }
    }
}

// Display the actual pie chart with spring animation
// the pie chart displays fat, carbs, and protein
struct PieChart: View {
    @ObservedObject var charDataObj = ChartDataContainer()
    @State var indexOfTappedSlice = -1
    @State var carbohydrates: Float
    @State var fats: Float
    @State var protein: Float
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<charDataObj.chartData.count) { index in
                    Circle()
                        .trim(from: index == 0 ? 0.0 : charDataObj.chartData[index-1].value/100,
                              to: charDataObj.chartData[index].value/100)
                        .stroke(charDataObj.chartData[index].color,lineWidth: 100)
                        .scaleEffect(index == indexOfTappedSlice ? 1.1 : 1.0)
                        .animation(.spring())
                }
            }.frame(width: 100, height: 200)
                .onAppear() {
                    calc()
                    self.charDataObj.calc()
                    //                    calc()
                }
            
            ForEach(0..<charDataObj.chartData.count) { index in
                HStack {
                    Text(charDataObj.chartData[index].title + ": " + String(format: "%.2f", Double(charDataObj.chartData[index].percent))+"%")
                        .onTapGesture {
                            indexOfTappedSlice = indexOfTappedSlice == index ? -1 : index
                        }
                        .font(indexOfTappedSlice == index ? .headline : .subheadline)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(charDataObj.chartData[index].color)
                        .frame(width: 15, height: 15)
                }
            }
            .padding(8)
            .frame(width: 300, alignment: .trailing)
        }
    }
    func calc(){
        var total = carbohydrates + fats + protein
        charDataObj.chartData =
        [ChartData(title: "Fat", color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), percent: CGFloat(100.0 * fats/total), value: 0),
         ChartData(title: "Carbs",color: Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)), percent: CGFloat(100.0 * carbohydrates/total), value: 0),
         ChartData(title: "Protein",color: Color(#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)), percent: CGFloat(100.0 * protein/total), value: 0)]
    }
}

//struct PieChart_Previews: PreviewProvider {
//    static var previews: some View {
//        PieChart()
//    }
//}
