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
    
    public var state:int = 0;
    
    public function ImageVO(file:FileReference)
    {
        this.file = file;
        
        file.addEventListener(Event.COMPLETE, completeHandler);
    }
    
    
    protected function completeHandler(event:Event):void
    {
        state = UPLOADED;
    }

}
}