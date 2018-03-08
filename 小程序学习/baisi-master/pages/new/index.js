import common from '../../utils/common'
var maxTime = 0;
var page = 1;
var id = 0;
Page({
    data: {
        /* 页面配置 */
        winWidth: 0,
        winHeight: 0,
        // tab切换
        currentTab: 0,
        scrollTop: 560,
        hidden: false,
        hasRefesh: false,
        dataList: [],
        videoList: [],
        picList: [],
        textList: []
    },
    onLoad: function () {
        var that = this;
        /**
         * 获取系统信息
         */
        wx.getSystemInfo({
            success: function (res) {
                that.setData({
                    winWidth: res.windowWidth,
                    winHeight: res.windowHeight
                });
            }
        });
    },
    onReady: function () {
        var that = this;
        common.index = 3
        wx.request({
            url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=1',
            header: {
                'content-type': 'application/json'
            },
            success: function (res) {
                that.setData({
                    dataList: res.data.list,
                    hidden: true
                })
                maxTime = res.data.info.maxtime;
            }
        })
    },
    getData:function(that){
        if (that.data.currentTab == 0) {
            common.index = 3
            wx.request({
                url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=1',
                header: {
                    'content-type': 'application/json'
                },
                success: function (res) {
                    that.setData({
                        dataList: res.data.list,
                        hidden: true
                    })
                    maxTime = res.data.info.maxtime;
                }
            })
        } else if (that.data.currentTab == 1) {
            common.index = 4
            wx.request({
                url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=41',
                header: {
                    'content-type': 'application/json'
                },
                success: function (res) {
                    that.setData({
                        videoList: res.data.list,
                        hidden: true
                    })
                    maxTime = res.data.info.maxtime;
                }
            })
        } else if (that.data.currentTab == 2) {
            common.index = 5
            wx.request({
                url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=10',
                header: {
                    'content-type': 'application/json'
                },
                success: function (res) {
                    that.setData({
                        picList: res.data.list,
                        hidden: true
                    })
                    maxTime = res.data.info.maxtime;
                }
            })
        } else if (that.data.currentTab == 3) {
            common.index = 6
            wx.request({
                url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=29',
                header: {
                    'content-type': 'application/json'
                },
                success: function (res) {
                    that.setData({
                        textList: res.data.list,
                        hidden: true
                    })
                    maxTime = res.data.info.maxtime;
                }
            })
        }
    },
    /**
     * 滑动切换tab
     */
    bindChange: function (e) {
        var that = this;
        if (that.data.currentTab === e.detail.current) {
            return false;
        } else {
            that.setData({
                currentTab: e.detail.current
            });
            that.getData(that);
        }
    },
    /**
     * 点击tab切换
     */
    swichNav: function (e) {
        var that = this;
        if (this.data.currentTab === e.target.dataset.current) {
            return false;
        } else {
            that.setData({
                currentTab: e.target.dataset.current
            });
            that.getData(that);
        }
    },
    refesh: function (e) {
        var that = this;
        that.setData({
            hasRefesh: true
        })
        page = 1;
        if (that.data.currentTab == 0) {
            wx.request({
                url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=1',
                header: {
                    'content-type': 'application/json'
                },
                success: function (res) {
                    that.setData({
                        dataList: res.data.list,
                        hidden: true,
                        hasRefesh: false
                    })
                }
            })
        } else if (that.data.currentTab == 1) {
            wx.request({
                url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=41',
                header: {
                    'content-type': 'application/json'
                },
                success: function (res) {
                    that.setData({
                        videoList: res.data.list,
                        hidden: true,
                        hasRefesh: false
                    })
                }
            })
        } else if (that.data.currentTab == 2) {
            wx.request({
                url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=10',
                header: {
                    'content-type': 'application/json'
                },
                success: function (res) {
                    that.setData({
                        picList: res.data.list,
                        hidden: true,
                        hasRefesh: false
                    })
                }
            })
        } else if (that.data.currentTab == 3) {
            wx.request({
                url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=29',
                header: {
                    'content-type': 'application/json'
                },
                success: function (res) {
                    that.setData({
                        textList: res.data.list,
                        hidden: true,
                        hasRefesh: false
                    })
                }
            })
        }

    },
    loadMore: function () {
        var that = this;
        that.setData({
            hidden: false
        });
        if (that.data.currentTab == 0) {
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
        } else if (that.data.currentTab == 1) {
            wx.request({
                url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=41&page=' + (page + 1) + '&maxtime=' + maxTime,
                header: {
                    'content-type': 'application/json'
                },
                success: function (res) {
                    page += 1;
                    maxTime = res.data.info.maxtime;
                    that.setData({
                        videoList: that.data.videoList.concat(res.data.list),
                        hidden: true
                    })
                }
            })
        } else if (that.data.currentTab == 2) {
            wx.request({
                url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=10&page=' + (page + 1) + '&maxtime=' + maxTime,
                header: {
                    'content-type': 'application/json'
                },
                success: function (res) {
                    page += 1;
                    maxTime = res.data.info.maxtime;
                    that.setData({
                        picList: that.data.picList.concat(res.data.list),
                        hidden: true
                    })
                }
            })
        } else if (that.data.currentTab == 3) {
            wx.request({
                url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=29&page=' + (page + 1) + '&maxtime=' + maxTime,
                header: {
                    'content-type': 'application/json'
                },
                success: function (res) {
                    page += 1;
                    maxTime = res.data.info.maxtime;
                    that.setData({
                        textList: that.data.textList.concat(res.data.list),
                        hidden: true
                    })
                }
            })
        }
    },
    toCommend: function (e) {
        id = e.target.dataset.id
        module.exports.id = id
        wx.navigateTo({
            url: '../commend/index'
        })
    }
})
