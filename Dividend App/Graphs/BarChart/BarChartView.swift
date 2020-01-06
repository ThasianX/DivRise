//
//  ChartView.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct BarChartView : View {
    @ObservedObject var data: ChartData
    public var title: String
    public var legend: String?
    public var style: ChartStyle
    public var formSize:CGSize
    public var dropShadow: Bool

//    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    
    @State private var touchLocation: CGFloat = -1.0
    @State private var showValue: Bool = false
    @State private var currentValue: Double = 0 {
        didSet{
            if(oldValue != self.currentValue && self.showValue) {
//                selectionFeedbackGenerator.selectionChanged()
                HapticFeedback.playSelection()
            }
        }
    }
    @State private var currentRecord: Record = .mock
    
    var isFullWidth:Bool {
        return self.formSize == ChartForm.large
    }
    public init(records: [Record], data: [Double], title: String, detailPrefix: String = "", detailSuffix: String = "", legend: String? = nil, style: ChartStyle = Styles.barChartStyleOrangeLight, form: CGSize? = ChartForm.medium, dropShadow: Bool? = true){
        self.data = ChartData(records: records, points: data)
        self.title = title
        self.legend = legend
        self.style = style
        self.formSize = form!
        self.dropShadow = dropShadow!
    }
    
    public var body: some View {
        ZStack{
            Rectangle()
                .fill(self.style.backgroundColor)
                .cornerRadius(20)
                .shadow(color: Color.gray, radius: self.dropShadow ? 8 : 0)
            VStack(alignment: .leading, spacing: 20){
                HStack{
                    if(!showValue){
                        Text(self.title)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(self.style.textColor)
                    }else{
                        Text("\(self.currentRecord.month) \(self.currentRecord.year) - $\(self.currentValue, specifier: "%.2f")")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(self.style.textColor)
                    }
                    Spacer()
                    if !showValue {
                        Image(systemName: "chart.bar")
                        .imageScale(.large)
                        .foregroundColor(self.style.legendTextColor)
                    } else {
                        HStack {
                            if ((self.currentValue / self.data.points.first!) - 1) >= 0 {
                                Image(systemName: "arrow.up")
                                .imageScale(.large)
                                .foregroundColor(self.style.legendTextColor)
                                Text("\((((self.currentValue / self.data.points.first!) - 1)*100), specifier: "%.0f")%")
                                .foregroundColor(self.style.textColor)
                            } else {
                                Image(systemName: "arrow.down")
                                .imageScale(.large)
                                .foregroundColor(self.style.legendTextColor)
                                Text("\((((self.currentValue / self.data.points.first!) - 1)*100), specifier: "%.0f")%")
                                .foregroundColor(self.style.textColor)
                            }
                        }
                    }
                }.padding()
                BarChartRow(data: data.points, accentColor: self.style.accentColor, secondGradientAccentColor: self.style.secondGradientColor, touchLocation: self.$touchLocation)
            }
        }.frame(minWidth:self.formSize.width, maxWidth: self.isFullWidth ? .infinity : self.formSize.width, minHeight:self.formSize.height, maxHeight:self.formSize.height)
            .gesture(DragGesture()
                .onChanged({ value in
                    self.touchLocation = value.location.x/self.formSize.width
                    self.showValue = true
                    self.currentValue = self.getCurrentValue()
                    self.currentRecord = self.getCurrentRecord()
                })
                .onEnded({ value in
                    self.showValue = false
                    self.touchLocation = -1
                })
        )
            .gesture(TapGesture()
        )
    }
    
    func getCurrentRecord()-> Record {
        let index = max(0,min(self.data.records.count-1,Int(floor((self.touchLocation*self.formSize.width)/(self.formSize.width/CGFloat(self.data.records.count))))))
        return self.data.records[index]
    }
    
    func getCurrentValue()-> Double {
        let index = max(0,min(self.data.points.count-1,Int(floor((self.touchLocation*self.formSize.width)/(self.formSize.width/CGFloat(self.data.points.count))))))
        return self.data.points[index]
    }
}

#if DEBUG
struct ChartView_Previews : PreviewProvider {
    static var previews: some View {
        BarChartView(records: [.mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock], data: [8,23,54,32,12,37,7,23,43], title: "Title", legend: "Legendary", form: CGSize(width: 300, height: 500))
    }
}
#endif
