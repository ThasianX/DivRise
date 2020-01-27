//
//  LineCard.swift
//  LineChart
//
//  Created by András Samu on 2019. 08. 31..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct LineChartView: View {
    //    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    @ObservedObject var data:ChartData
    public var title: String
    public var detailPrefix: String
    public var detailSuffix: String
    public var shortenDouble: Bool
    public var allowGesture: Bool
    public var legend: String?
    public var style: ChartStyle
    public var formSize:CGSize
    public var dropShadow: Bool
    public var estimate: Bool
    
    @State private var touchLocation:CGPoint = .zero
    @State private var showIndicatorDot: Bool = false
    @State private var currentValue: Double = 2 {
        didSet{
            if (oldValue != self.currentValue && showIndicatorDot) {
                //                selectionFeedbackGenerator.selectionChanged()
                HapticFeedback.playSelection()
            }
            
        }
    }
    @State private var currentRecord: Record = .mock
    let frame = CGSize(width: 180, height: 120)
    
    public init(records: [Record], data: [Double], title: String, detailPrefix: String = "", detailSuffix: String = "", shortenDouble: Bool = false, allowGesture: Bool = true, legend: String? = nil, style: ChartStyle = Styles.lineChartDarkStyle, form: CGSize? = ChartForm.medium, dropShadow: Bool? = true, estimate: Bool = false){
        self.data = ChartData(records: records, points: data)
        self.title = title
        self.detailPrefix = detailPrefix
        self.detailSuffix = detailSuffix
        self.shortenDouble = shortenDouble
        self.allowGesture = allowGesture
        self.legend = legend
        self.style = style
        self.formSize = form!
        self.dropShadow = dropShadow!
        self.estimate = estimate
    }
    
    public var body: some View {
        ZStack(alignment: .center){
            RoundedRectangle(cornerRadius: 20).fill(self.style.backgroundColor).frame(width: frame.width, height: 240, alignment: .center).shadow(color: .white, radius: self.dropShadow ? 8 : 0)
            VStack(alignment: .leading){
                if(!self.showIndicatorDot){
                    VStack(alignment: .leading, spacing: 8){
                        Text(self.title).font(.title).bold().foregroundColor(self.style.textColor)
                        if (self.legend != nil){
                            Text(self.legend!).font(.callout).foregroundColor(self.style.legendTextColor)
                        }
                    }
                    .transition(.opacity)
                    .animation(.easeIn(duration: 0.1))
                    .padding([.leading, .top])
                }else{
                    VStack {
                        Spacer()
                            .frame(height: 20)
                        HStack{
                            Spacer()
                            Text("\(self.currentRecord.month)\((self.currentRecord.day != nil) ? " \(self.currentRecord.day!), " : " ")\(self.currentRecord.year)")
                            .foregroundColor(self.style.textColor)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            
                            if shortenDouble { Text("\(detailPrefix)\(self.currentValue.shortStringRepresentation)\(detailSuffix)")
                                .font(.system(size: 35, weight: .bold, design: .default))
                                .foregroundColor(self.style.textColor)
                            } else { Text("\(detailPrefix)\(self.currentValue, specifier: "%.2f")\(detailSuffix)")
                                .font(.system(size: 35, weight: .bold, design: .default))
                                .foregroundColor(self.style.textColor)
                            }
                            
                            Spacer()
                        }
                    }
                    .transition(.scale)
                    
                }
                Spacer()
                GeometryReader{ geometry in
                    Line(data: self.data, frame: .constant(geometry.frame(in: .local)), touchLocation: self.$touchLocation, showIndicator: self.$showIndicatorDot, estimate: self.estimate)
                }
                .frame(width: frame.width, height: frame.height+30)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .offset(x: 0, y: 0)
            }.frame(width: self.formSize.width, height: self.formSize.height)
        }
        .gesture((allowGesture) ? (DragGesture()
        .onChanged({ value in
            self.touchLocation = value.location
            self.showIndicatorDot = true
            self.getClosestDataPoint(toPoint: value.location, width:self.frame.width, height: self.frame.height)
        })
            .onEnded({ value in
                self.showIndicatorDot = false
            })
            ) : nil)
    }
    
    @discardableResult func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> CGPoint {
        let stepWidth: CGFloat = width / CGFloat(data.points.count-1)
        let stepHeight: CGFloat = height / CGFloat(data.points.max()! + data.points.min()!)
        
        let index:Int = Int(round((toPoint.x)/stepWidth))
        if (index >= 0 && index < data.points.count){
            self.currentValue = self.data.points[index]
            self.currentRecord = self.data.records[index]
            return CGPoint(x: CGFloat(index)*stepWidth, y: CGFloat(self.data.points[index])*stepHeight)
        }
        return .zero
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LineChartView(records: [.mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock], data: [0.4894840180369058, 0.5384738882135731, 0.5007662742045343, 0.5069929507840947, 0.4770271058000583, 0.451138886207895, 0.43058826430588265, 0.3802580349645011, 0.3721135568627892, 0.4151055314002707], title: "Line chart", detailPrefix: "$", legend: "Basic")
                .environment(\.colorScheme, .light)
        }
    }
}
