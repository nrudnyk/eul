//
//  PreferenceGeneralView.swift
//  eul
//
//  Created by Gao Sun on 2020/8/15.
//  Copyright © 2020 Gao Sun. All rights reserved.
//

import SwiftUI

extension Preference {
    struct GeneralView: View {
        var body: some View {
            VStack(alignment: .leading) {
                Text("Display")
                    .section()
                Text("Components")
                    .section()
                ComponentsView()
            }
        }
    }

    struct ComponentsView: View {
        @State var dragging: MenuItem?
        @GestureState var offsetWidth: CGFloat = 0

        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text("Status Bar")
                    .subsection()
                HStack {
                    ForEach(MenuItem.components) { item in
                        HStack(spacing: 8) {
                            Image(item.rawValue)
                                .resizable()
                                .frame(width: 12, height: 12)
                            Text(item.rawValue)
                                .normal()
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .background(Color.selectedBackground)
                        .cornerRadius(4)
                        .offset(x: self.dragging == item ? self.offsetWidth : 0)
                        .zIndex(self.dragging == item ? 1 : 0)
                        .gesture(DragGesture()
                        .updating(self.$offsetWidth, body: { (value, state, _) in
                                state = value.translation.width
                            })
                            .onChanged { value in
                                self.dragging = item
                            }
                            .onEnded { _ in
                                self.dragging = nil
                            }
                        )
                    }
                    Spacer()
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .border(Color.border)
                .clipped()
                Text("Available")
                    .subsection()
            }
        }
    }
}
