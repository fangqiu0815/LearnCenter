/**
 * Created by weiyuyao on 2017/1/15.
 */
import common from '../../utils/common'
import news from '../new/index'
import choice from '../choice/index'
var page = 1;
var lastcid = 0;
Page({
    data: {
        winWidth: 0,
        winHeight: 0,
        dataList: [],
        dataDetail: {},
        dataCommend:{},
        hidden: false
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
        console.log(choice)
        if (common.index == 2) {
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
                    for (var i = 0; i < that.data.dataList.length; i++) {
                        if (choice.id === that.data.dataList[i].id) {
                            that.setData({
                                dataDetail: that.data.dataList[i]
                            })
                        }
                    }
                    wx.request({
                        url: 'http://api.budejie.com/api/api_open.php?a=dataList&c=comment&data_id='+choice.id,
                        header: {
                            'content-type': 'application/json'
                        },
                        success: function (res) {
                            that.setData({
                                dataCommend: res.data.data
                            })
                            if(res.data.data) {
                                lastcid = res.data.data[res.data.data.length - 1].id;
                            }
                        }
                    })
                }
            })
        }else if (common.index == 3) {
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
                    for (var i = 0; i < that.data.dataList.length; i++) {
                        if (news.id === that.data.dataList[i].id) {
                            that.setData({
                                dataDetail: that.data.dataList[i]
                            })
                        }
                    }
                    wx.request({
                        url: 'http://api.budejie.com/api/api_open.php?a=dataList&c=comment&data_id='+news.id,
                        header: {
                            'content-type': 'application/json'
                        },
                        success: function (res) {
                            that.setData({
                                dataCommend: res.data.data
                            })
                            if(res.data.data) {
                                lastcid = res.data.data[res.data.data.length - 1].id;
                            }
                        }
                    })
                }
            })
        } else if (common.index == 4) {

            wx.request({
                url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=41',
                header: {
                    'content-type': 'application/json'
                },
                success: function (res) {
                    that.setData({
                        dataList: res.data.list,
                        hidden: true
                    })
                    for (var i = 0; i < that.data.dataList.length; i++) {
                        if (news.id === that.data.dataList[i].id) {
                            that.setData({
                                dataDetail: that.data.dataList[i]
                            })
                        }
                    }
                    wx.request({
                        url: 'http://api.budejie.com/api/api_open.php?a=dataList&c=comment&data_id='+news.id,
                        header: {
                            'content-type': 'application/json'
                        },
                        success: function (res) {
                            that.setData({
                                dataCommend: res.data.data
                            })
                            if(res.data.data) {
                                lastcid = res.data.data[res.data.data.length - 1].id;
                            }
                        }
                    })
                }
            })
        }else if (common.index == 5) {
            wx.request({
                url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=10',
                header: {
                    'content-type': 'application/json'
                },
                success: function (res) {
                    that.setData({
                        dataList: res.data.list,
                        hidden: true
                    })
                    for (var i = 0; i < that.data.dataList.length; i++) {
                        if (news.id === that.data.dataList[i].id) {
                            that.setData({
                                dataDetail: that.data.dataList[i]
                            })
                        }
                    }
                    wx.request({
                        url: 'http://api.budejie.com/api/api_open.php?a=dataList&c=comment&data_id='+news.id,
                        header: {
                            'content-type': 'application/json'
                        },
                        success: function (res) {
                            that.setData({
                                dataCommend: res.data.data
                            })
                            if(res.data.data) {
                                lastcid = res.data.data[res.data.data.length - 1].id;
                            }
                        }
                    })
                }
            })
        }else if (common.index == 6) {
            wx.request({
                url: 'http://api.budejie.com/api/api_open.php?a=list&c=data&type=29',
                header: {
                    'content-type': 'application/json'
                },
                success: function (res) {
                    that.setData({
                        dataList: res.data.list,
                        hidden: true
                    })
                    for (var i = 0; i < that.data.dataList.length; i++) {
                        if (news.id === that.data.dataList[i].id) {
                            that.setData({
                                dataDetail: that.data.dataList[i]
                            })
                        }
                    }
                    wx.request({
                        url: 'http://api.budejie.com/api/api_open.php?a=dataList&c=comment&data_id='+news.id,
                        header: {
                            'content-type': 'application/json'
                        },
                        success: function (res) {
                            that.setData({
                                dataCommend: res.data.data
                            })
                            if(res.data.data) {
                                lastcid = res.data.data[res.data.data.length - 1].id;
                            }
                        }
                    })
                }
            })
        }



    },
    lower:function(){
        var that = this
        that.setData({
            hidden: false
        });
        wx.request({
            url: 'http://api.budejie.com/api/api_open.php?a=dataList&c=comment&data_id='+news.id+'&page='+(page + 1)+'&lastcid'+lastcid,
            header: {
                'content-type': 'application/json'
            },
            success: function (res) {
                if(res.data.data){
                    page += 1;
                    that.setData({
                        dataCommend: that.data.dataCommend.concat(res.data.data),
                        hidden: true

                    })
                    lastcid = res.data.data[res.data.data.length-1].id;
                }else {
                    that.setData({
                        hidden: true

                    })
                }
            }
        })
    }
})