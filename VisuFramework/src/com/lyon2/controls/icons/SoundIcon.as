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
package com.lyon2.controls.icons
{
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	
	import mx.formatters.SwitchSymbolFormatter;
	import mx.skins.ProgrammaticSkin;
	
	public class SoundIcon extends ProgrammaticSkin
	{
		override public function get height():Number {return 12}
		override public function get width():Number {return 12}

		override protected function updateDisplayList(unscaledWidth:Number, 
														unscaledHeight:Number):void
		{
			
			var w:Number = unscaledWidth ;
			var h:Number = unscaledHeight;
			
			var g:Graphics = graphics
			
			g.beginFill(0x454545);
			g.lineStyle(1,0x454545);
			g.drawRect(0,4,3,4);
			g.endFill();
			//triangle
			
			g.beginFill(0x454545);
			g.moveTo(2,6);
			g.lineTo(6,1);
			g.lineTo(6,11);
			g.lineTo(2,6);
			g.endFill();
			switch(name)
			{
				case "upIcon":
				case "overIcon":
				case "downIcon":
				case "disabledIcon":
					
					break;
				case "selectedUpIcon":
				case "selectedOverIcon":
				case "selectedDownIcon":
				case "selectedDisabledIcon":
					g.moveTo(8,4);
				 	g.curveTo(9,6,8,8);
				 	g.moveTo(9,1);
				 	g.curveTo(12,6,9,11);		
					break;
			}
			
			
			
			var light:DropShadowFilter = 
				new DropShadowFilter(2,135,0xFFFFFFF,.5,2,2,1,1);
			var dark:DropShadowFilter = 
				new DropShadowFilter(2,135,0x000000,.5,2,2,1,1,true);
			filters = [dark,light];			
		}
	}
}
