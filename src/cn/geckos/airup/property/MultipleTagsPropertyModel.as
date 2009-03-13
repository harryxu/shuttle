package cn.geckos.airup.property
{
import mx.utils.StringUtil;
    
    
/**
 * 为一系列对象设置标签(就是那种分类用的标签)
 * 
 */
public class MultipleTagsPropertyModel extends MultipleObjectsPropertyModel
{
    
    /**
     * 设置标签字符 类似  "flash flex java code"
     */
    override public function set value(value:*):void
    {
        
        if( _value == value ) {
            return;
        }
        
        _value = value
            
        var newTags:String = StringUtil.trim(String(value));
        var newTagsGroup:Array = newTags.split(' ');
            
        for each( var obj:Object in owner )
        {
	        if( newTags.length ) {
	            var oldTagsGroup:Array = String(obj[propertyName] || '').split(' ');
	            
	            for each( var tag:String in newTagsGroup )
	            {
	                // 如果新标签不存在于现有标签中, 就要把新标签加进去
	                if( oldTagsGroup.indexOf(tag) < 0 ) {
	                    oldTagsGroup.push(tag);
	                }
	            }
	            
	            obj[propertyName] = oldTagsGroup.join(' ');
	        }
        }
        
    }
    
    public function MultipleTagsPropertyModel(owner:Object, propertyName:String)
    {
        super(owner, propertyName);
    }
        
}
}