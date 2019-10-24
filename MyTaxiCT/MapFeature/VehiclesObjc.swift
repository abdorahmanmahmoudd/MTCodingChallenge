//
//	Vehicles.swift
//
//	Create by Abdorahman Mahmoud on 15/6/2019
//	Copyright © 2019. All rights reserved.

import Foundation

@objc
class VehiclesObjc : NSObject, NSCoding{

	@objc var poiList : [VehicleObjc]!
    
    override init() {}

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		poiList = [VehicleObjc]()
		if let poiListArray = dictionary["poiList"] as? [[String:Any]]{
			for dic in poiListArray{
				let value = VehicleObjc(fromDictionary: dic)
				poiList.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if poiList != nil{
			var dictionaryElements = [[String:Any]]()
			for poiListElement in poiList {
				dictionaryElements.append(poiListElement.toDictionary())
			}
			dictionary["poiList"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         poiList = aDecoder.decodeObject(forKey :"poiList") as? [VehicleObjc]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if poiList != nil{
			aCoder.encode(poiList, forKey: "poiList")
		}

	}

}
