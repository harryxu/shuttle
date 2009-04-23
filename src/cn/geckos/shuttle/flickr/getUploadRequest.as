package cn.geckos.shuttle.flickr
{

import com.adobe.crypto.MD5;
import com.adobe.utils.StringUtil;
import com.adobe.webapis.flickr.*;

import flash.net.FileReference;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
    
public function getUploadRequest(   service:FlickrService,
                                    fileReference:FileReference,
                                    title:String = "",
									description:String = "",
									tags:String = "",
									is_public:Boolean = false,
									is_friend:Boolean = false,
									is_family:Boolean = false,
									safety_level:int = 0,
									content_type:int = 0,
									hidden:Boolean = false) : URLRequest 
{
								            
            // Bail out if missing the necessary authentication parameters
            if (service.api_key == "" || service.secret == "" || service.token == "") {
                return null;
            }

            // Bail out if application doesn't have authorisation to writ or delete from account
            if (service.permission != AuthPerm.WRITE && service.permission != AuthPerm.DELETE) {
                return null;
            }

            // The upload method requires signing, so go through
            // the signature process

            // Flash sends both the 'Filename' and the 'Upload' values
            // in the body of the POST request, so these are needed for the signature
            // as well, otherwise Flickr returns a error code 96 'invalid signature'
            var sig:String = StringUtil.trim( service.secret );
            sig += "Filename" + fileReference.name;
            sig += "UploadSubmit Query"; //             
            sig += "api_key" + StringUtil.trim( service.api_key );
            sig += "auth_token" + StringUtil.trim( service.token );        
            
            // optional values, in alphabetical order as required
            if ( content_type != ContentType.DEFAULT ) sig += "content_type" + content_type;
            if ( description != "" ) sig += "description" + description;
            if ( hidden ) sig += "hidden" + ( hidden ? 1 : 0 );
            if ( is_family ) sig += "is_family" + ( is_family ? 1 : 0 );
            if ( is_friend ) sig += "is_friend" + ( is_friend ? 1 : 0 );
            sig += "is_public" + ( is_public ? 1 : 0 );
            if ( safety_level != SafetyLevel.DEFAULT ) sig += "safety_level" + safety_level;
            if ( tags != "" ) sig += "tags" + tags;
            if ( title != "" ) sig += "title" + title;

            var vars:URLVariables = new URLVariables();
            vars.auth_token = StringUtil.trim( service.token );
            vars.api_sig = MD5.hash( sig );
            vars.api_key = StringUtil.trim( service.api_key );
            
            // optional values, in alphabetical order as required
            if ( content_type != ContentType.DEFAULT ) vars.content_type = content_type;
            if ( description != "" ) vars.description = description;
            if ( hidden ) sig += vars.hidden = ( hidden ? 1 : 0 );
            if ( is_family ) vars.is_family = ( is_family ? 1 : 0 );
            if ( is_friend ) vars.is_friend = ( is_friend ? 1 : 0 );
            vars.is_public = ( is_public ? 1 : 0 );
            if ( safety_level != SafetyLevel.DEFAULT ) vars.safety_level = safety_level;
            if ( tags != "" ) vars.tags = tags;
            if ( title != "" ) vars.title = title;

            var request:URLRequest = new URLRequest("http://api.flickr.com/services/upload/");
            request.data = vars;
            request.method = URLRequestMethod.POST;
            
            return request;
}

}
