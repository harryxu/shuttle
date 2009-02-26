package cn.geckos.airup.models.vo
{
import flash.events.Event;
import flash.net.FileReference;
    

[Bindable]
public class ImageVO
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
    }
    
    
    protected function completeHandler(event:Event):void
    {
        _state = UPLOADED;
    }
    
    protected function openHandler(event:Event):void
    {
        _state = UPLOADING;
    }
    
    public function cancelUpload():void
    {
        file.cancel();
        if( state == UPLOADING ) {
            _state = NOT_UPLOAD;
        }
    }

}
}