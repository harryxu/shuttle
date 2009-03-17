package cn.geckos.airup.views
{
import cn.geckos.airup.Notices;
import cn.geckos.airup.views.components.FlickrAuthTokenPanel;
import cn.geckos.airup.views.components.ProfileBox;

import com.adobe.webapis.flickr.AuthResult;
import com.adobe.webapis.flickr.User;

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
            Notices.GET_FLICKR_AUTH_FROB_SUCCESS,
            Notices.GET_FLICKR_AUTH_TOKEN_SUCCESS,
            Notices.CHECK_FLICKR_TOKEN_OK,
            Notices.GET_FLICKR_USER_INFO_SUCCESS,
            Notices.GET_QUOTA_SUCESS,
        ];
    }
    
    override public function handleNotification(notification:INotification):void
    {
        var data:Object = notification.getBody();
        
        var user:User;
        if( data is User ) {
            user = User(data);
        }
        
        switch( notification.getName() )
        {
            case Notices.NO_DEFAULT_ACCOUNT:
                component.signBtn.visible = true;
	            break;
	        
	        // 得到 auth frob
	        case Notices.GET_FLICKR_AUTH_FROB_SUCCESS:
	           var loginURL:String = data['loginURL'];
	           navigateToURL(new URLRequest(loginURL));
	           
	           _authTokenPanel = new FlickrAuthTokenPanel();
	           _authTokenPanel.loginURL = loginURL;
	           _authTokenPanel.addEventListener(FlickrAuthTokenPanel.GET_TOKEN, getTokenClickHandler);
	           
	           PopUpManager.addPopUp(_authTokenPanel, DisplayObject(Application.application), true);
	           PopUpManager.centerPopUp(_authTokenPanel);
	           break;
	        
	        // 得到 auth token
	        case Notices.GET_FLICKR_AUTH_TOKEN_SUCCESS:
	           PopUpManager.removePopUp(_authTokenPanel);
	           
	           component.signBtn.visible = false;
	           
	           // 通知将账户保存到本地配置文件中
	           sendNotification(Notices.ADD_ACCOUNT, {
	                    'id': AuthResult(data).user.username,
	               'service': 'flickr'
	           });
	        case Notices.CHECK_FLICKR_TOKEN_OK:
	           trace('auth token ok');
	           
	           var authResult:AuthResult = AuthResult(data);
	           component.nameLabel.text = authResult.user.username;
	           sendNotification(Notices.GET_FLICKR_USER_INFO, authResult.user.nsid);
	           break;
	           
	        //   
	        // user info   
	        //
	        case Notices.GET_FLICKR_USER_INFO_SUCCESS:
	           component.avatar.source = 'http://farm' + user.iconFarm
	               + '.static.flickr.com/' + user.iconServer + '/buddyicons/' 
	               + user.nsid + '.jpg';
	           break;
	           
	        case Notices.GET_QUOTA_SUCESS:
	           component.bytesUsed = user.bandwidthUsed;
	           component.bytesMax = user.bandwidthMax;
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