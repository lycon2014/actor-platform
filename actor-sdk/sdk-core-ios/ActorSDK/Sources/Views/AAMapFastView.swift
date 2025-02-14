//
//  Copyright (c) 2014-2015 Actor LLC. <https://actor.im>
//

import Foundation
import MapKit

public class AAMapFastView: UIImageView {
    
    static private var mapCache = AASwiftlyLRU<String, UIImage>(capacity: 16)
    
    let mapWidth: CGFloat
    let mapHeight: CGFloat
    var mapKey: String? = nil
    
    public init(mapWidth: CGFloat, mapHeight: CGFloat) {
        self.mapWidth = mapWidth
        self.mapHeight = mapHeight
        super.init(image: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(latitude: Double, longitude: Double) {
        let key = "\(Int(latitude * 1000000))_\(Int(longitude * 1000000))"
        
        // Same Key
        if (self.mapKey == key) {
            return
        }
        
        self.mapKey = key
        
        let cached = AAMapFastView.mapCache[key]
        if (cached != nil) {
            self.image = cached
            return
        }
        
        let options = MKMapSnapshotOptions()
        options.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        options.size = CGSizeMake(mapWidth, mapHeight)
        options.scale = UIScreen.mainScreen().scale
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.startWithCompletionHandler { snapshot, error in
            if let img = snapshot?.image {
                let rounded = img.roundCorners(img.size.width, h: img.size.height, roundSize: 14)
                dispatchOnUi {
                    AAMapFastView.mapCache[key] = rounded
                    self.image = rounded
                }
            }
        }
    }
}