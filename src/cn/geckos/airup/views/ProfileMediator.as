package cn.geckos.airup.views
{
import cn.geckos.airup.Notices;
import cn.geckos.airup.views.components.FlickrAuthTokenPanel;
import cn.geckos.airup.views.components.ProfileBox;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.net.navigateToURL;

import mx.core.Application;
import mx.managers.PopUpManager;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;

public class ProfileMediator extends Mediator
{
    public static const NAME:String = 'ProfileMediator';
    
    public function get component():ProfileBox
    {
        return viewComponent as ProfileBox;
    }
    
    private var _authTokenPanel:FlickrAuthTokenPanel;
    
    /**
     * 
     * @param mediatorName
     * @param viewComponent
     * 
     */    
    public function ProfileMediator(mediatorName:String=null, viewComponent:Object=null)
    {
        super(mediatorName, viewComponent);
        
        component.signBtn.addEventListener(MouseEvent.CLICK, signBtnClickHandler);
    }
    
    override public function listNotificationInterests():Array
    {
        return [
            Notices.NO_DEFAULT_ACCOUNT,
            Notices.FLICKR_GOT_AUTH_FROB,
            Notices.FLICKR_GOT_AUTH_TOKEN,
            Notices.FLICKR_CHECK_TOKEN_OK,
        ];
    }
    
    override public function handleNotification(notification:INotification):void
    {
        var data:Object = notification.getBody();
        
        switch( notification.getName() )
        {
            case Notices.NO_DEFAULT_ACCOUNT:
                component.signBtn.visible = true;
	            break;
	            
	        case Notices.FLICKR_GOT_AUTH_FROB:
	           var loginURL:String = data['loginURL'];
	           navigateToURL(new URLRequest(loginURL));
	           
	           _authTokenPanel = new FlickrAuthTokenPanel();
	           _authTokenPanel.loginURL = loginURL;
	           _authTokenPanel.addEventListener(FlickrAuthTokenPanel.GET_TOKEN, getTokenClickHandler);
	           
	           PopUpManager.addPopUp(_authTokenPanel, DisplayObject(Application.application), true);
	           PopUpManager.centerPopUp(_authTokenPanel);
	           break;
	        
	        case Notices.FLICKR_GOT_AUTH_TOKEN:
	           PopUpManager.removePopUp(_authTokenPanel);
	           break;
        } 
    }
    
    
    private function signBtnClickHandler(event:MouseEvent):void
    {
        component.signBtn.enabled = false;
        sendNotification(Notices.GET_FLICKR_AUTH_FROB);
    }
    
    private function getTokenClickHandler(event:Event):void
    {
        _authTokenPanel.completeBtn.enabled = false;
        sendNotification(Notices.GET_FLICKR_AUTH_TOKEN);
    }
        
}
}