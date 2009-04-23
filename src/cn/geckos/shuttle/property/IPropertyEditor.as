package cn.geckos.shuttle.property
{
    
public interface IPropertyEditor
{
    
    function get display():Object;
    
    function applyProperty():void;
    
    function bindTo(model:IPropertyModel):void;
        
}
}
