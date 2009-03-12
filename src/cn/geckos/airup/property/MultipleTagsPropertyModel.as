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
        var newTags:String = StringUtil.trim(String(value));
        
        if( newTags.length > 0 && newTags != _value ) {
            
            var newTagsGroup:Array = newTags.split(' ');
            var oldTagsGroup:Array = String(_value||'').split(' ');
            
            for each( var tag:String in newTagsGroup )
            {
                // 如果新标签不存在于现有标签中, 就要把新标签加进去
                if( oldTagsGroup.indexOf(tag) < 0 ) {
                    oldTagsGroup.push(tag);
                }
            }
            
            super.value = oldTagsGroup.join(' ');
        }
    }
    
    public function MultipleTagsPropertyModel(owner:Object, propertyName:String)
    {
        super(owner, propertyName);
    }
        
}
}