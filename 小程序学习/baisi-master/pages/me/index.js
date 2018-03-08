Page({
    data:{
        myList: [],
        hidden: false
    },
    onReady: function () {
        var that = this;
        wx.request({
            url: 'http://api.budejie.com/api/api_open.php?a=square&c=topic',
            header: {
                'content-type': 'application/json'
            },
            success: function(res) {
                that.setData({
                    myList: res.data.square_list,
                    hidden: true
                });
            }
        })
    }
})