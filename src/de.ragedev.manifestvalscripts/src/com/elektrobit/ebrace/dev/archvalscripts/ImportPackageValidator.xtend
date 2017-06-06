package com.elektrobit.ebrace.dev.archvalscripts

import java.io.File
import java.io.FileInputStream
import java.util.List
import java.util.jar.Attributes
import java.util.jar.Manifest

class ImportPackageValidator {

	def List<ResultValue> validate(List<File> manifestFiles) {
		
		val resultList = newArrayList()
		
		manifestFiles.forEach [ manifestFile | 
			val Manifest manifest = new Manifest(new FileInputStream(manifestFile))
			val Attributes attr = manifest.mainAttributes

			var boolean resultStatus = false

			if (attr.getValue("Import-Package") !== null)
				resultStatus = true
				
			resultList.add(new ResultValue(manifestFile, resultStatus))

		]
		
		resultList
	}

}
