package cn.geckos.airup.models.vo
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.FileReference;

import mx.events.PropertyChangeEvent;
    

[Bindable]
public class ImageVO extends EventDispatcher
{
    public static const NOT_UPLOAD:int  = 0
    public static const UPLOADING:int   = 1;
    public static const UPLOADED:int    = 2;
    
    
    public var file:FileReference;
    
    private var _state:int = 0;
    public function get state():int
    {
        return _state;
    }
    
    
    public function ImageVO(file:FileReference)
    {
        this.file = file;
        
        file.addEventListener(Event.COMPLETE, completeHandler);
        file.addEventListener(Event.OPEN, openHandler);
        file.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
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