package com.elektrobit.ebrace.dev.archvalscripts

import java.io.File
import java.io.IOException
import java.nio.file.FileVisitResult
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths
import java.nio.file.SimpleFileVisitor
import java.nio.file.attribute.BasicFileAttributes

class ImportPackageFullValidator {

	extension static ScriptConsole console = new ScriptConsole("Import-Package-Full-Warn-Script")

	private static String includeRegex = ".*com\\.elektrobit\\.ebrace\\..*meta-inf.*manifest.mf"

	def static void main(String[] args) {

		val workspace = new File(args.get(0));
		
		if(args.length > 1)
			includeRegex = args.get(1)

		val files = newArrayList()
		Files.walkFileTree(
			Paths.get(workspace.absolutePath),
			new SimpleFileVisitor<Path>() {
				override def FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException 
                {
					if (file.toString.toLowerCase.matches(includeRegex))
						files.add(file.toFile)

					return FileVisitResult.CONTINUE;
				}
			}
		)

		val result = new ImportPackageValidator().validate(files.toList)
		result.size.toString.println

		val failures = result.filter[!ok]
		val validItems = newArrayList()
		validItems.addAll(result)
		validItems.removeAll(failures)

		if (failures.size > 0) {
			failures.toList.toString.println;
		}

		"".println
		"---------------".println
		"Overall result".println;
		"---------------".println;
		("#Plugins: " + result.size).println;
		("Failures: " + failures.size).println;
		("Valid:    " + validItems.size).println
		"---------------".println
	}

}
