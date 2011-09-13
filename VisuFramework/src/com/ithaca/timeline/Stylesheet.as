package com.ithaca.timeline
{
	import com.ithaca.timeline.ObselSkin;
	import com.ithaca.timeline.TraceLineGroup;
	import com.ithaca.timeline.skins.IconSkin;
	import com.ithaca.traces.Obsel;
	import com.ithaca.visu.model.Model;
	
	import flash.events.Event;
	
	import mx.events.FlexEvent;

	public class Stylesheet
	{
		static private var tracelineGroupColorIndex : uint = 0;
		static public var ZoomContextInitPercentWidth : Number = 30;
		static public var renderersSidePadding : Number = 25;
		
		static public var obselsSkinsSelectors : Array = [  { id : 'Message' , 		selector : new SelectorRegexp('Message','type') },
															{ id : 'Document' ,  	selector : new SelectorRegexp('Document','type')},
															{ id : 'Instructions' ,	selector : new SelectorRegexp('Instructions','type')},															
															{ id : 'Marker' , 		selector : new SelectorRegexp('Marker', 'type') },
															{ id : 'Keyword' , 		selector : new SelectorRegexp('Keyword', 'type') },
															{ id : 'Activity' , 	selector : new SelectorRegexp('ActivityStart', 'type') },
															{ id : 'Comment' , 		selector : new SelectorRegexp('omment','type')} ];
		
		public function Stylesheet()
		{
		}	
		 		
		public function getParameteredSkin( obsel : Obsel, traceline : TraceLine ) :  ObselSkin 
		{ 	
			var obselSkin : ObselSkin = new ObselSkin( obsel, traceline );	
			for each ( var item : Object in obselsSkinsSelectors )
				if ( (item.selector as ISelector).isObselMatching( obsel ) )
				{
					obselSkin.styleName = item.id;	
					if(item.id == "Marker")
					{
						// check if can edit marker
						if(Model.getInstance().canEditObsel(obsel))
						{
							obselSkin.editable = true;
						}
					}
					break;
				}
				
			return obselSkin;
		}
		
		static public function getTracelineGroupColor( tlg : TraceLineGroup ) : uint
		{
			var fillColors : Array = tlg.getStyle( "fillColors" ) as Array;	
			return fillColors[ tracelineGroupColorIndex++ % fillColors.length ] ;
		}
		
	}
}