package business
{

import com.ithaca.visu.controls.SessionHomeElement;
import com.ithaca.visu.events.SessionEvent;
import com.ithaca.visu.events.UserEvent;
import com.ithaca.visu.modules.ModuleInfo;
import com.lyon2.visu.model.Model;
import com.lyon2.visu.model.Session;
import com.lyon2.visu.vo.SessionUserVO;
import com.lyon2.visu.vo.SessionVO;
import com.lyon2.visu.vo.UserVO;

import events.*;

import flash.events.DataEvent;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.sampler.Sample;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.controls.Text;
import mx.core.FlexGlobals;
import mx.logging.ILogger;
import mx.logging.Log;
import mx.messaging.events.MessageEvent;


public class HomeManager
{
	// properties
	
	[Bindable]
	public var connectedUsers : ArrayCollection;

	[Bindable]
	public var listSessionDate : ArrayCollection = new ArrayCollection();
	
	[Bindable]
	public var fluxActivity : ArrayCollection;
	
	[Bindable]
	public var listSessionView:ArrayCollection;

	
	private var logger : ILogger = Log.getLogger('HomeManager');
	
	private var dispatcher:IEventDispatcher;
	
	// constructor
	public function HomeManager(dispatcher:IEventDispatcher)
	{
		this.dispatcher = dispatcher;
	}

	// methods
	/**
	 * Set date list
	 */ 
	public function onLoadListSessionsDates(arSessionDates:Array, map:Object):void{
		
		// FIXME PROBLEME TOO TIMES CALL THIS FUNCTION, EXISTE TOO MAPS !!!!!
		if( Model.getInstance().getSessionDate().length == 0)
		{
			Model.getInstance().setSessionDate(arSessionDates);
			this.listSessionDate = Model.getInstance().getSessionDate();						
		}
	}
	
	/**
	 * Set session list, call for each date  
	 */ 
	public function onLoadListSessionByDate(listSessionByDate:Array, sessionDate:String):void{
		Model.getInstance().setListSessionsByDate(listSessionByDate, sessionDate);
		// get all users how will participate in session of logged user
		var nbrSession:uint = listSessionByDate.length;
		for(var nSession:uint = 0; nSession < nbrSession ; nSession++)
		{
			var event:UserEvent = new UserEvent(UserEvent.LOAD_LIST_USERS_SESSION);
			event.sessionId = listSessionByDate[nSession].id_session;
			event.sessionDate = sessionDate;
			dispatcher.dispatchEvent(event);			
		}		
	}
	
	/**
	 * Set user list for a session
	 */ 
	public function onLoadListUsersSession(listUsers: Array, sessionId : int, sessionDate: String):void
	{
		// set users session
	    Model.getInstance().setListUsersSession(listUsers, sessionId);
		
		var sessionEvent:SessionEvent = new SessionEvent(SessionEvent.UPDATE_LIST_SESSION);
		var listSession:ArrayCollection = Model.getInstance().getListSessionByDate(sessionDate);
		sessionEvent.listSession = listSession;
		sessionEvent.sessionDate = sessionDate;
		dispatcher.dispatchEvent(sessionEvent);	
	}
	
	/**
	 * init flux activity
	 */ 
	public function getFluxActivity():void{
		// initialisation flux activity
		this.fluxActivity = Model.getInstance().getFluxActivity();
	}


	public function onError(session:SessionVO = null):void{
		
	}

}
}