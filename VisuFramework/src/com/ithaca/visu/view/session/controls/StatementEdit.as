/**
 * Copyright Université Lyon 1 / Université Lyon 2 (2009,2010)
 * 
 * <ithaca@liris.cnrs.fr>
 * 
 * This file is part of Visu.
 * 
 * This software is a computer program whose purpose is to provide an
 * enriched videoconference application.
 * 
 * Visu is a free software subjected to a double license.
 * You can redistribute it and/or modify since you respect the terms of either 
 * (at least one of the both license) :
 * - the GNU Lesser General Public License as published by the Free Software Foundation; 
 *   either version 3 of the License, or any later version. 
 * - the CeCILL-C as published by CeCILL; either version 2 of the License, or any later version.
 * 
 * -- GNU LGPL license
 * 
 * Visu is free software: you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 * 
 * Visu is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with Visu.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * -- CeCILL-C license
 * 
 * This software is governed by the CeCILL-C license under French law and
 * abiding by the rules of distribution of free software.  You can  use, 
 * modify and/ or redistribute the software under the terms of the CeCILL-C
 * license as circulated by CEA, CNRS and INRIA at the following URL
 * "http://www.cecill.info". 
 * 
 * As a counterpart to the access to the source code and  rights to copy,
 * modify and redistribute granted by the license, users are provided only
 * with a limited warranty  and the software's author,  the holder of the
 * economic rights,  and the successive licensors  have only  limited
 * liability. 
 * 
 * In this respect, the user's attention is drawn to the risks associated
 * with loading,  using,  modifying and/or developing or reproducing the
 * software by the user in light of its specific status of free software,
 * that may mean  that it is complicated to manipulate,  and  that  also
 * therefore means  that it is reserved for developers  and  experienced
 * professionals having in-depth computer knowledge. Users are therefore
 * encouraged to load and test the software's suitability as regards their
 * requirements in conditions enabling the security of their systems and/or 
 * data to be ensured and,  more generally, to use and operate it in the 
 * same conditions as regards security. 
 * 
 * The fact that you are presently reading this means that you have had
 * knowledge of the CeCILL-C license and that you accept its terms.
 * 
 * -- End of licenses
 */

package com.ithaca.visu.view.session.controls
{
	import com.ithaca.visu.model.ActivityElement;
	import com.ithaca.visu.view.session.controls.event.SessionEditEvent;
	
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import mx.controls.Image;
	
	import spark.components.RichText;
	import spark.components.supportClasses.SkinnableComponent;
	
	[SkinState("normal")]
	[SkinState("open")]
	
	public class StatementEdit extends SkinnableComponent
	{
		[SkinPart("true")]
		public var textContent:RichText;
		
		[SkinPart("true")] 
		public var buttonDelete:Image;
		
		[SkinPart("true")] 
		public var buttonEdit:Image;
		
		[SkinPart("true")] 
		public var buttonUp:Image;

		[SkinPart("true")] 
		public var buttonDown:Image;

		public var currentMouseCursor:String;
		private var normal:Boolean = true;
		protected var _activityElement:ActivityElement;
		
		public function StatementEdit()
		{
			super();
			currentMouseCursor  = Mouse.cursor; 
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName,instance);
			if(instance == buttonDelete)
			{
				buttonDelete.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
				buttonDelete.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
				buttonDelete.toolTip = "effacer";
			}
			if(instance == buttonEdit)
			{
				buttonEdit.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);				
				buttonEdit.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
				buttonEdit.toolTip = "editer";
			}
			
			if(instance == buttonUp)
			{
				buttonUp.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);				
				buttonUp.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
				buttonUp.toolTip = "move up";
			}
			
			if(instance == buttonDown)
			{
				buttonDown.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);				
				buttonDown.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
				buttonDown.toolTip = "move down";
			}
			
			if(instance == textContent)
			{
				textContent.text = _activityElement.data;
			}
		}
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName,instance);
			if(instance == buttonDelete)
			{
				buttonDelete.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);
				buttonDelete.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			}
			if(instance == buttonEdit)
			{
				buttonEdit.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);				
				buttonEdit.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			}
			
			if(instance == buttonUp)
			{
				buttonUp.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);				
				buttonUp.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			}
			
			if(instance == buttonDown)
			{
				buttonDown.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOverButton);				
				buttonDown.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOutButton);
			}
		}
		
		public function get activityElement():ActivityElement {return _activityElement; }
		public function set activityElement(value:ActivityElement):void
		{
			_activityElement = value;
		}
		
		override protected function getCurrentSkinState():String
		{
			return !enabled? "disabled" : normal? "normal" : "close";
		}
		
		public function setEditabled(value:Boolean):void
		{
			normal = value;
			this.invalidateSkinState();
		}
		// srt cursor mouse HAND
		protected function onMouseOverButton(event:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.BUTTON;	
		}
		
		// set cursor mouse AROOW  
		protected function onMouseOutButton(event:MouseEvent):void
		{
			Mouse.cursor = this.currentMouseCursor;
		}
		public function deleteStatement():void
		{
			var deleteStatement:SessionEditEvent = new SessionEditEvent(SessionEditEvent.PRE_DELETE_ACTIVITY_ELEMENT);
			deleteStatement.activityElement = _activityElement;
			this.dispatchEvent(deleteStatement);
		}
		public function updateStatement(value:String):void
		{
			var updateStatement:SessionEditEvent = new SessionEditEvent(SessionEditEvent.PRE_UPDATE_ACTIVITY_ELEMENT);
			_activityElement.data = value;
			updateStatement.activityElement = _activityElement;
			this.dispatchEvent(updateStatement);
		}
		
		
	}
}