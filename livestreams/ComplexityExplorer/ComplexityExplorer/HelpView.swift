//
//  HelpView.swift
//  ComplexityExplorer
//
//  Created by James Clarke on 12/14/24.
//

import SwiftUI

struct HelpItem: Decodable, Identifiable {
    var id: String
    var notation: String
    var description: String
    var examples: [String]
}

struct HelpView: View {
    let helpItems: [HelpItem] = Bundle.main.decode("help.json")
    var selectedItem: Set<GrowthRate>
    @Binding var showingHelp: Bool
    
    var selectedHelpItems: [HelpItem] {
        helpItems.filter {
            helpItem in
            selectedItem.contains {
                $0.id == helpItem.id
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(selectedHelpItems) {
                    helpItem in
                    VStack(alignment: .leading) {
                        Text(helpItem.id)
                            .font(.title2)
                            .bold()
                        
                        Text(helpItem.notation)
                            .foregroundStyle(.secondary)
                            .font(.headline)
                            .fontDesign(.serif)
                            .italic()
                        
                        Text("**Exampltes:** \(helpItem.examples.joined(separator: ", ")).")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 24)
                }
            }
            .padding(10)
        }
        .inspectorColumnWidth(min: 200, ideal: 300)
        .toolbar {
            ToolbarItem {
                Spacer()
            }
            
            ToolbarItem {
                Button("Toggle Hepl", systemImage: "sidebar.trailing") {
                    showingHelp.toggle()
                }
                    
            }
        }
        
        
    }
    
    
}

#Preview {
//    HelpView()
}
