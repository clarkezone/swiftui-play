//
//  ImmersiveView.swift
//  AVP Hourglass proto
//
//  Created by James Clarke on 1/16/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @Environment(AppModel.self) var appModel
    
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)
                guard let emitterPoint = immersiveContentEntity.findEntity(named: "ParticalEmitterPoint") else {
                    return
                }
                // Create sand particles
                let sandEntity = Entity()
                
                // Create emitter entity
                      let emitterEntity = Entity()
                      emitterEntity.transform = emitterPoint.transform
                
                // Add particle emitter
                var emitterComponent = ParticleEmitterComponent()
                emitterComponent.mainEmitter.birthRate = 100
                emitterComponent.mainEmitter.lifeSpan = 4.0
                emitterComponent.isEmitting = true
                
                emitterEntity.components[ParticleEmitterComponent.self] = emitterComponent
                
                // Add visual appearance for particles
                let particleMesh = MeshResource.generateSphere(radius: 0.01)
                let particleMaterial = UnlitMaterial(color: .yellow) // Or your preferred sand color
                sandEntity.components[ModelComponent.self] = ModelComponent(
                    mesh: particleMesh,
                    materials: [particleMaterial]
                )
                
                sandEntity.components[ParticleEmitterComponent.self] = emitterComponent
                
                // Position the emitter at our reference point
                sandEntity.transform = emitterPoint.transform
                
                // Add physics
                sandEntity.components[PhysicsBodyComponent.self] = .init(
                    massProperties: .default,
                    material: .generate(friction: 0.5, restitution: 0.3),
                    mode: .dynamic
                )
                
                content.add(sandEntity)
                content.add(emitterEntity)
            }
            
        }
    }
}

//#Preview(immersionStyle: .full) {
//    ImmersiveView()
//        .environment(AppModel())
//}
