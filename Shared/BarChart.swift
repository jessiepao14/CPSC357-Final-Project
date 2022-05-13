//
//  BarChart.swift
//  NutriPal (iOS)
//
//  Created by Jessie Pao on 4/30/22.
//

import SwiftUI

// Struct to hold the data from the bar chart
struct DataItem: Identifiable {
    let id = UUID()
    let name: String
    let value: Double
}

struct ChartHeaderView: View {
    var title: String
    var height: CGFloat
    
    var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.semibold)
            .frame(height: height)
            .foregroundColor(Color("SecondaryColor"))
    }
}

struct ChartAreaView: View {
    var data: [DataItem]
    
    var body: some View {
        GeometryReader { gr in
            let fullBarHeight = gr.size.height * 0.90
            let maxValue = data.map { $0.value }.max()!
            
            ZStack {
                RoundedRectangle(cornerRadius: 5.0)
                    .fill(Color("TertiaryColor"))
                VStack {
                    HStack(spacing:0) {
                        ForEach(data) { item in
                            BarView(
                                name: item.name,
                                value: item.value,
                                maxValue: maxValue,
                                fullBarHeight: Double(fullBarHeight))
                        }
                    }
                    .padding(4)
                }
            }
        }
    }
}

struct BarChartView: View {
    var title: String
    var data: [DataItem]
    
    var body: some View {
        GeometryReader { gr in
            let headHeight = gr.size.height * 0.10
            VStack {
                ChartHeaderView(title: title, height: headHeight)
                ChartAreaView(data: data)
            }
        }
    }
}

struct BarView: View {
    var name: String
    var value: Double
    var maxValue: Double
    var fullBarHeight: Double
    
    var body: some View {
        let barHeight = (Double(fullBarHeight) / maxValue) * value
        VStack {
            Spacer()
            ZStack {
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(.blue)
                        .frame(height: CGFloat(barHeight), alignment: .trailing)
                }
                
                VStack {
                    Spacer()
                    Text("\(value, specifier: "%.0F")")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
            Text(name)
        }
        .padding(.horizontal, 4)
    }
}

struct BarChart: View {
    let chartData: [DataItem] = [
        DataItem(name: "Mon", value: 898),
        DataItem(name: "Tue", value: 670),
        DataItem(name: "Wed", value: 725),
        DataItem(name: "Thu", value: 439),
        DataItem(name: "Fri", value: 1232),
        DataItem(name: "Sat", value: 771),
        DataItem(name: "Sun", value: 365)
    ]
    
    
    var body: some View {
        //        VStack {
        //            Text("Weekly Nutrition Breakdown")
        //                .font(.title)
        //                .foregroundColor(Color("SecondaryColor"))
        //
        //            BarChartView(
        //                title: "Daily Calorie Count", data: chartData)
        //            .frame(width: 350, height: 500, alignment: .center)
        //
        //            Spacer()
        //        }
        BarChartView(
            title: "Daily Calorie Count", data: chartData)
            .frame(width: 350, height: 500, alignment: .center)
    }
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart()
    }
}
