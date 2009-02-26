package cn.geckos.airup.views
{
import cn.geckos.airup.Notices;
import cn.geckos.airup.models.vo.ImageVO;
import cn.geckos.airup.views.components.ImageListBox;

import flash.events.FileListEvent;
import flash.events.MouseEvent;
import flash.filesystem.File;
import flash.net.FileFilter;

import mx.events.MenuEvent;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;

public class ImageListMediator extends Mediator
{
    
    public static const NAME:String = 'ImageListMediator';
    
    /**
     * 允许选择的图片文件格式
     */
    private static var imageTypeFilter:Array = [
        new FileFilter("Images(*.jpg;*.gif;*.png;*.bmp)", "*.jpg;*.gif;*.png;*.bmp"),
    ];
    
    /**
     * 用来选择图片文件的File对象 
     */    
    private var _file:File;
    
    
    public function get component():ImageListBox
    {
        return viewComponent as ImageListBox;
    }
    
    /**
     * Constructor 
     * @param mediatorName
     * @param viewComponent
     * 
     */
    public function ImageListMediator(mediatorName:String=null, viewComponent:Object=null)
    {
        super(mediatorName, viewComponent);
        
        component.addImgBtn.addEventListener(MouseEvent.CLICK, addImgBtnClickHandler);
        component.uploadBtn.addEventListener(MenuEvent.ITEM_CLICK, uploadBtnClickHandler);
        component.removeBtn.addEventListener(MenuEvent.ITEM_CLICK, removeBtnClickHandler);
    }
    
    private function getFile():File
    {
        if( !_file ) {
            _file = new File();
            _file.addEventListener(FileListEvent.SELECT_MULTIPLE, fileSelectMultipleHandler);
        }
        return _file;
    }
    
    
    /**
     * 浏览图片文件
     */
    private function addImgBtnClickHandler(event:MouseEvent):void
    {
        getFile().browseForOpenMultiple('Select images for upload.', imageTypeFilter);
    }
    
    /**
     * 选择文件后把图片添加到列表中
     */
    private function fileSelectMultipleHandler(event:FileListEvent):void
    {
        var files:Array = event.files;
        
        for each( var file:File in files ) 
        {
            var fileExist:Boolean;
            for each( var vo:ImageVO in component.listData )
            {
                if( file.nativePath == File(vo.file).nativePath ) {
                    fileExist = true;
                }
            }
            
            if( !fileExist ) {
                component.listData.addItem(new ImageVO(file));
            }
            
        }
    }
    
    /**
     * 上传按钮事件
     * 
     */
    private function uploadBtnClickHandler(event:MenuEvent):void
    {
        // 单击按钮上传选中的照片
        var data:Object = component.list.selectedItems;
        
        // 单击按钮菜单上传全部
        if( event.index == 1 ) {
            data = component.listData;
        }
        
        for each( var vo:ImageVO in data )
        {
            if( vo.state == ImageVO.NOT_UPLOAD ) {
                sendNotification(Notices.UPLOAD, vo);
            }
        }
    }
    
    /**
     * 删除按钮事件
     * 
     */
    private function removeBtnClickHandler(event:MenuEvent):void
    {
        // 单击按钮删除选中的图片
        var data:Object = component.list.selectedItems;
        
        // 单击按菜单钮删除上传图片
        if( event.index == 1 ) {
            data = component.listData;
        }
        
        // 停止正在上传的文件
        for each( var vo:ImageVO in component.list.selectedItems )
        {
            if( vo.state == ImageVO.UPLOADING ) {
                vo.cancelUpload();
            }
        }
        
        if( event.index == 0 ) {
	        component.removeSelectedItems();
        }
        else {
            component.listData.removeAll();
        }
    }
    
    override public function listNotificationInterests():Array
    {
        return [
            Notices.CHECK_FLICKR_TOKEN_OK,
            Notices.GET_FLICKR_AUTH_TOKEN_SUCCESS,
        ];
    }
    
    override public function handleNotification(notification:INotification):void
    {
        switch( notification.getName() )
        {
            case Notices.CHECK_FLICKR_TOKEN_OK:
            case Notices.GET_FLICKR_AUTH_TOKEN_SUCCESS:
                component.enabled = true;
                break;
        }
    }
        
}
}