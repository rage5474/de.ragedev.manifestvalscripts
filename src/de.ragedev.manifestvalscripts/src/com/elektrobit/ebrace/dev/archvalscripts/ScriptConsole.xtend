package com.elektrobit.ebrace.dev.archvalscripts

import org.eclipse.ui.console.ConsolePlugin
import org.eclipse.ui.console.IOConsole
import org.eclipse.ui.console.IOConsoleOutputStream
import org.eclipse.ui.console.MessageConsole

class ScriptConsole {
	
	private val IOConsoleOutputStream outputStream
	
	new(String consoleName) {
		val console = new MessageConsole(consoleName, null)
		val IOConsole[] consoles = newArrayOfSize(1)
		consoles.set(0,console)
				
		ConsolePlugin.getDefault().getConsoleManager().addConsoles(consoles);
		ConsolePlugin.getDefault().getConsoleManager().showConsoleView(console);
		
		outputStream = console.newOutputStream
	}
	
	def println(String text)
	{
		print(text + "\n")
	}
	
	def print(String text)
	{
		outputStream.write(text)
	}
	
}