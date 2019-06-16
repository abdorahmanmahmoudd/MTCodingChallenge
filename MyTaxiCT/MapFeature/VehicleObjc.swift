//
//	Vehicle.swift
//
//	Create by Abdorahman Mahmoud on 15/6/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class VehicleObjc : NSObject, NSCoding{

	var coordinate : CoordinateObjc!
	var fleetType : String!
	var heading : Double!
	var id : Int!

    override init() {}
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let coordinateData = dictionary["coordinate"] as? [String:Any]{
			coordinate = CoordinateObjc(fromDictionary: coordinateData)
		}
		fleetType = dictionary["fleetType"] as? String
		heading = dictionary["heading"] as? Double
		id = dictionary["id"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if coordinate != nil{
			dictionary["coordinate"] = coordinate.toDictionary()
		}
		if fleetType != nil{
			dictionary["fleetType"] = fleetType
		}
		if heading != nil{
			dictionary["heading"] = heading
		}
		if id != nil{
			dictionary["id"] = id
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         coordinate = aDecoder.decodeObject(forKey: "coordinate") as? CoordinateObjc
         fleetType = aDecoder.decodeObject(forKey: "fleetType") as? String
         heading = aDecoder.decodeObject(forKey: "heading") as? Double
         id = aDecoder.decodeObject(forKey: "id") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if coordinate != nil{
			aCoder.encode(coordinate, forKey: "coordinate")
		}
		if fleetType != nil{
			aCoder.encode(fleetType, forKey: "fleetType")
		}
		if heading != nil{
			aCoder.encode(heading, forKey: "heading")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}

	}

}
