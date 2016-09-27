source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!
platform :ios, '8.0'

def sdkios_dependecias
    pod "Firebase"
    pod "Firebase/Core"
    pod "Firebase/Database"
    pod "Firebase/Auth"
    pod "GeoFire", :git => "https://github.com/firebase/geofire-objc.git"
    
    pod "Mapbox-iOS-SDK"
    pod "MapboxDirections.swift", :git => "https://github.com/mapbox/MapboxDirections.swift.git", :tag => "v0.6.0"
end

target 'GeoSample' do
	sdkios_dependecias
end
