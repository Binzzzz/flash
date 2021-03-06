/*****************************************************
*  
*  Copyright 2010 Adobe Systems Incorporated.  All Rights Reserved.
*  
*****************************************************
*  The contents of this file are subject to the Mozilla Public License
*  Version 1.1 (the "License"); you may not use this file except in
*  compliance with the License. You may obtain a copy of the License at
*  http://www.mozilla.org/MPL/
*   
*  Software distributed under the License is distributed on an "AS IS"
*  basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
*  License for the specific language governing rights and limitations
*  under the License.
*   
*  
*  The Initial Developer of the Original Code is Adobe Systems Incorporated.
*  Portions created by Adobe Systems Incorporated are Copyright (C) 2010 Adobe Systems 
*  Incorporated. All Rights Reserved. 
*  
*****************************************************/

package org.osmf.player.debug
{
	import org.osmf.logging.TraceLogger;
	
	public class DebuggerLogger extends TraceLogger
	{
		public function DebuggerLogger(name:String, debugger:Debugger)
		{
			super(name);
			
			this.name = name;
			this.debugger = debugger;
		}
		
		// Internals
		//
		
		override protected function logMessage(level:String, message:String, params:Array):void
		{
			var msg:String = "";
			
			// add name and params
			msg += "[" + name + "] " + applyParams(message, params);
			
			// trace the message
			debugger.send(level, msg);
		}
		
		private function applyParams(message:String, params:Array):String
		{
			var result:String = message;
			var numParams:int = params.length;
			
			for (var i:int = 0; i < numParams; i++)
			{
				result = result.replace(new RegExp("\\{" + i + "\\}", "g"), params[i]);
			}
			
			return result;
		}
		
		private var name:String;
		private var debugger:Debugger;
	}
}