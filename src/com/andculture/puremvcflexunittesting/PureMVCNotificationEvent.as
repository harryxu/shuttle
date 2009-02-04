/* Copyright (c) 2008, andCulture Inc.
 * All rights reserved.
 *
 * NOTICE: You are permitted to use, modify, and distribute this file
 * in accordance with the terms of the BSD license agreement accompanying it.
 */

package com.andculture.puremvcflexunittesting {
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.INotification;
	
	/**
	 * Custom event that wraps the PureMVC INotification object. Dispatch this
	 * event in PureMVCTestCase in order for handlers to have access to the
	 * notification details.
	 */
	public class PureMVCNotificationEvent extends Event {
		private var _notification:INotification;
		
		/**
		 * Gets or sets the dispatched INotification object.
		 */
		public function get notification():INotification {
			return _notification;
		}
		
		/**
		 * @private
		 */
		public function set notification(value:INotification):void {
			_notification = value;
		}
		
		/**
		 * Constructor.
		 * 
		 * @param notification INotification that was observed.
		 * @param bubbles Specifies whether the event can bubble up
		 * the display list hierarchy.
		 * @param cancelable Specifies whether the behavior associated
		 * with the event can be prevented.
		 */
		public function PureMVCNotificationEvent(notification:INotification, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(notification.getName(), bubbles, cancelable);
			_notification = notification;
		}
	}
}