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
    public var legend: String?
    public var style: ChartStyle
    public var formSize:CGSize
    public var dropShadow: Bool
    
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
    
    public init(records: [Record], data: [Double], title: String, legend: String? = nil, style: ChartStyle = Styles.lineChartStyleOne, form: CGSize? = ChartForm.medium, dropShadow: Bool? = true){
        self.data = ChartData(records: records, points: data)
        self.title = title
        self.legend = legend
        self.style = style
        self.formSize = form!
        self.dropShadow = dropShadow!
    }
    
    public var body: some View {
        ZStack(alignment: .center){
            RoundedRectangle(cornerRadius: 20).fill(self.style.backgroundColor).frame(width: frame.width, height: 240, alignment: .center).shadow(radius: self.dropShadow ? 8 : 0)
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
                            Text("\(self.currentRecord.month) \(self.currentRecord.year)")
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            Text("\(self.currentValue, specifier: "%.2f")")
                                .font(.system(size: 41, weight: .bold, design: .default))
                            Spacer()
                        }
                    }
                    .transition(.scale)
                    .animation(.spring())
                    
                }
                Spacer()
                GeometryReader{ geometry in
                    Line(data: self.data, frame: .constant(geometry.frame(in: .local)), touchLocation: self.$touchLocation, showIndicator: self.$showIndicatorDot)
                }
                .frame(width: frame.width, height: frame.height)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .offset(x: 0, y: 0)
            }.frame(width: self.formSize.width, height: self.formSize.height)
        }
        .gesture(DragGesture()
        .onChanged({ value in
            self.touchLocation = value.location
            self.showIndicatorDot = true
            self.getClosestDataPoint(toPoint: value.location, width:self.frame.width, height: self.frame.height)
        })
            .onEnded({ value in
                self.showIndicatorDot = false
            })
        )
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
            LineChartView(records: [.mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock], data: [0.6137386018237082, 0.2815539332538736, 0.17518342474101156, 0.24931948665991222, -1.1515280464216635, 1.1460104011887073, 0.2818422889043964, -1.3491616766467065, 1.5056442831215968, 0.6401420838971583, -56.699696969696966], title: "Line chart", legend: "Basic")
                .environment(\.colorScheme, .light)
        }
    }
}
