Page({
    onLoad: function() {
        var that = this;
        /**
         * 获取系统信息
         */
        wx.getSystemInfo( {
            success: function( res ) {
               console.log(res)
            }
        });
    }
})