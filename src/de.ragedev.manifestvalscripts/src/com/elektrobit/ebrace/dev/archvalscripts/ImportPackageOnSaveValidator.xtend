// onSave : *.MF
package com.elektrobit.ebrace.dev.archvalscripts

import java.io.File
import java.io.FileInputStream
import java.util.jar.Attributes
import java.util.jar.Manifest
import org.eclipse.core.resources.ResourcesPlugin
import org.eclipse.core.runtime.IPath
import org.eclipse.core.runtime.Path


class ImportPackageOnSaveValidator {

	extension static ScriptConsole console = new ScriptConsole("Import-Package-Warn-Script")

	def static void main(String[] args) {
		val Manifest manifest = new Manifest(new FileInputStream(new File(getPathToManifestFile(args.get(0)))));
		val Attributes attr = manifest.mainAttributes

		if (attr.getValue("Import-Package") !== null)
			("WARN: Import-Package not allowed: " + args.get(0)).println
		else
			("INFO: Import-Package free: " + args.get(0)).println
	}

	def static String getPathToManifestFile(String ipath) {
		val IPath path = new Path(ipath)
		val file = ResourcesPlugin.getWorkspace().getRoot().getFile(path)
//		val warn = file.createMarker("com.elektrobit.ebrace.dev.archvalscripts.importpackage.warning")
//		
//		warn.setAttribute(IMarker.SEVERITY, IMarker.SEVERITY_WARNING);
//		warn.setAttribute(IMarker.MESSAGE, "My bla");
//		warn.setAttribute(IMarker.LINE_NUMBER, 2);
		return file.getRawLocation().toOSString()
	}

}
