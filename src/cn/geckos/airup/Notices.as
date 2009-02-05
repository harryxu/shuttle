package cn.geckos.airup
{
public class Notices
{
    /**
     * 登录默认账户
     */
    public static const AUTH_DEFAULT_ACCOUNT:String = 'authDefaultAccount';
    
    /**
     * 没有默认账户
     */
    public static const NO_DEFAULT_ACCOUNT:String = 'noDefaultAccount';
    
    //
    //  Flickr 服务相关
    //
    
    public static const GET_FLICKR_AUTH_FROB:String = 'getFlickrAuthFrob';
    
    public static const GET_FLICKR_AUTH_TOKEN:String = 'getFlickrAuthToken';
    
    /**
     * model获取到了flickr登录URL
     */    
    public static const FLICKR_GOT_AUTH_FROB:String = 'flickrGotAuthFrob';
    
    /**
     * 获取到了flickr auth token 
     */    
    public static const FLICKR_GOT_AUTH_TOKEN:String = 'flickrGotAuthToken';
    
    /**
     * flickr token 可正常使用 
     */    
    public static const FLICKR_CHECK_TOKEN_OK:String = 'flickrCheckTokenOK';
    
    /**
     * flickr token 无效 
     */    
    public static const FLICKR_CHECK_TOKEN_FAILD:String = 'flickrCheckTokenFailed';

}
}