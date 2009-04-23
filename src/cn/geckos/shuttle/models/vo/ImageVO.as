package cn.geckos.shuttle.models.vo
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.FileReference;

import mx.events.PropertyChangeEvent;
    

[Bindable]
dynamic public class ImageVO extends EventDispatcher
{
    public static const NOT_UPLOAD:int  = 0
    public static const UPLOADING:int   = 1;
    public static const UPLOADED:int    = 2;
    public static const WAITTING:int    = 3;
    
    
    public var file:FileReference;
    
    private var _state:int = 0;
    public function get state():int
    {
        return _state;
    }
    
    
    public function ImageVO(file:FileReference)
    {
        this.file = file;
        this.title = file.name;
        
        file.addEventListener(Event.COMPLETE, completeHandler);
        file.addEventListener(Event.OPEN, openHandler);
        file.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
    }
    
    public function wait():Boolean
    {
        if( state < 1 ) {
            _state = WAITTING;
	        dispatchEvent( new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
            return true;
        }
        
        return false;
    }
    
    
    protected function completeHandler(event:Event):void
    {
        _state = UPLOADED;
        dispatchEvent( new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
    }
    
    protected function openHandler(event:Event):void
    {
        _state = UPLOADING;
        dispatchEvent( new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
    }
    
    protected function errorHandler(event:Event):void
    {
        _state = NOT_UPLOAD;
        dispatchEvent( new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
    }
    
    public function cancelUpload():void
    {
        file.cancel();
        if( state == UPLOADING ) {
            _state = NOT_UPLOAD;
            dispatchEvent( new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
        }
    }
    

}
}
