//
//	Coordinate.swift
//
//	Create by Abdorahman Mahmoud on 15/6/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

@objc
class CoordinateObjc : NSObject, NSCoding{

    @objc
	var latitude : NSNumber!
    
    @objc
	var longitude : NSNumber!

    override init() {}

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		latitude = dictionary["latitude"] as? NSNumber
		longitude = dictionary["longitude"] as? NSNumber
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if latitude != nil{
			dictionary["latitude"] = latitude
		}
		if longitude != nil{
			dictionary["longitude"] = longitude
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         latitude = aDecoder.decodeObject(forKey: "latitude") as? NSNumber
         longitude = aDecoder.decodeObject(forKey: "longitude") as? NSNumber

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if latitude != nil{
			aCoder.encode(latitude, forKey: "latitude")
		}
		if longitude != nil{
			aCoder.encode(longitude, forKey: "longitude")
		}

	}

}
