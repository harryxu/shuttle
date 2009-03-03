package cn.geckos.airup.property
{
import flash.display.DisplayObject;
    
public interface IPropertyEditor
{
    
    function get display():DisplayObject;
    
    function applyProperty():void;
    
    function bindTo(property:IPropertyModel):void;
        
}
}