import common from '../../utils/common'
var maxTime = 0;
var page = 1;
var currentTab = 4;
var id = 0;
Page( {
    data: {
        /* 页面配置 */
        winWidth: 0,
        winHeight: 0,
        // tab切换
        currentTab: 0,
        scrollTop: 560,
        hidden: false,
        hasRefesh: false,
        dataList: []
    },
    onLoad: function() {
        var that = this;
        /**
         * 获取系统信息
         */
        wx.getSystemInfo( {
            success: function( res ) {
                that.setData( {
                    winWidth: res.windowWidth,
                    winHeight: res.windowHeight
                });
            }
        });
    },
    onReady:function (){
        var that = this;
        common.index = 2
        wx.request({
            url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=1',
            header: {
                'content-type': 'application/json'
            },
            success: function(res) {
                that.setData({
                    dataList: res.data.list,
                    hidden: true
                })
            }
        })
    },
    refesh: function (e) {
        var that = this;
        that.setData({
            hasRefesh: true
        })
        page = 1;
        wx.request({
            url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=1',
            header: {
                'content-type': 'application/json'
            },
            success: function(res) {
                that.setData({
                    dataList: res.data.list,
                    hidden: true,
                    hasRefesh:false
                })
            }
        })
    },
    loadMore: function() {
        var that = this;
        that.setData({
            hidden: false
        });
        wx.request({
            url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=1&page=' + (page + 1) + '&maxtime=' + maxTime,
            header: {
                'content-type': 'application/json'
            },
            success: function (res) {
                page += 1;
                maxTime = res.data.info.maxtime;
                that.setData({
                    dataList: that.data.dataList.concat(res.data.list),
                    hidden: true
                })
            }
        })
    },
    toCommend: function (e) {
        id = e.target.dataset.id
        console.log(id)
        module.exports.id = id
        wx.navigateTo({
            url: '../commend/index'
        })
    }
})