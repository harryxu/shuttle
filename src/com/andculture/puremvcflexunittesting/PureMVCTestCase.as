/* Copyright (c) 2008, andCulture Inc.
 * All rights reserved.
 *
 * NOTICE: You are permitted to use, modify, and distribute this file
 * in accordance with the terms of the BSD license agreement accompanying it.
 */

package com.andculture.puremvcflexunittesting {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import flexunit.framework.TestCase;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.interfaces.IView;
	import org.puremvc.as3.patterns.observer.Observer;
	
	/**
	 * Extends TestCase to allow testing of PureMVC Proxies. PureMVC proxies
	 * don't throw events so I'm cheating.  This is probably really terrible,
	 * but it's the only solution I could find.  There doesn't appear to be too
	 * many people testing PureMVC code with FlexUnit even through PureMVC
	 * itself is.  Maybe there's a way to "properly" test asynchronous PureMVC
	 * notifications in FlexUnit, but until that time, let the suckiness
	 * commence.
	 */
	public class PureMVCTestCase extends TestCase {
		
		/**
		 * Constructor.
		 * 
		 * @param methodName Optional test method name to run.  If null, it will
		 * run all methods prefixed with "test".
		 */
		public function PureMVCTestCase(methodName:String = null) {
			super(methodName);
		}
		
		/**
		 * Method to use the EventDispatcher hack to listen for a PureMVC
		 * notification on a proxy. addAsync()'s internal callback expects an
		 * Event as its first parameter and Notifications obviously don't pass
		 * events so we have to cheat by wrapping the received Notification in
		 * a PureMVCNotificationEvent object to pass up the event hierarchy.
		 * 
		 * @param view View used to register an observer.
		 * @param proxy Proxy that will be sending out the notification.
		 * @param notificationName Notification name to listen for.
		 * @param callback Callback function to fire when the notification is received.
		 * @param timeout Timeout in milliseconds addAsync() will wait for the
		 * notification until it's declared a failure.
		 */
		public function registerObserver(view:IView, proxy:IProxy, notificationName:String, callback:Function, timeout:int):void {
			// Create the hacky EventDispatcher used to throw PureMVCNotificationEvents.
			var hackyDispatcher:EventDispatcher = new EventDispatcher();
			
			// Listen for the notification event on the hacky dispather.  The event type
			// will be equal to the notification name.
			hackyDispatcher.addEventListener(notificationName, addAsync(callback, timeout));
			
			// Handler listening for the proxy to dispatch the specified notification.
			var handler:Function = function(notification:INotification):void {
				
				// Notification received so dispatch a new PureMVCNotificationEvent with
				// the same name of the notification and give it the received INotification
				// object.
				hackyDispatcher.dispatchEvent(new PureMVCNotificationEvent(notification));
			};
			
			// Manually register an observer on this proxy for the specified notification.
			view.registerObserver(notificationName, new Observer(handler, this));
		}
	}
}