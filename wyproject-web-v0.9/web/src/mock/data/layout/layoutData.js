const routeDatas = [
  {
    name: '首页',
    icon: 'dashboard',
    group: '/home',
    groupName: 'first',
    to: '/home'
  },
  {
    name: '系统管理',
    icon: 'dashboard',
    group: '/system-manage',
    groupName: 'first',
    children: [
      {
        name: '用户管理',
        group: '/system-manage/user',
        icon: 'dashboard',
        children: [
          {
            name: '用户基础信息',
            group: '/system-manage/user/base',
            icon: 'dashboard',
            to: '/system-manage/user/base'
          },
          {
            name: '用户授权信息',
            group: '/system-manage/user/oauth',
            icon: 'dashboard',
            to: '/system-manage/user/oauth'
          }
        ]
      },
      {
        name: '角色管理',
        group: '/system-manage',
        to: '/system-manage/role'
      },
      {
        name: '菜单管理',
        group: '/system-manage',
        to: '/system-manage/menu'
      },
      {
        name: '部门管理',
        group: '/system-manage',
        to: '/system-manage/department'
      },
      {
        name: '岗位管理',
        group: '/system-manage',
        to: '/system-manage/post'
      },
      {
        name: '字典管理',
        group: '/system-manage',
        to: '/system-manage/dict'
      },
      {
        name: '参数管理',
        group: '/system-manage',
        to: '/system-manage/parameter'
      },
      {
        name: '通知公告',
        group: '/system-manage',
        to: '/system-manage/notice'
      },
      {
        name: '日志管理',
        icon: 'dashboard',
        group: '/system-manage/log',
        children: [
          {
            name: '操作日志',
            group: '/system-manage/log',
            to: '/system-manage/log/operate'
          },
          {
            name: '登录日志',
            group: '/system-manage/log',
            to: '/system-manage/log/login'
          }
        ]
      }
    ]
  },
  {
    name: '系统监控',
    icon: 'dashboard',
    group: '/system-monitor',
    groupName: 'first',
    children: [
      {
        name: '在线用户',
        group: '/system-monitor',
        to: '/system-monitor/online-user'
      },
      {
        name: '定时任务',
        group: '/system-monitor',
        to: '/system-monitor/time-task'
      },
      {
        name: '数据监控',
        group: '/system-monitor',
        to: '/system-monitor/data-monitor'
      },
      {
        name: '服务监控',
        group: '/system-monitor',
        to: '/system-monitor/service-monitor'
      },
      {
        name: '缓存监控',
        group: '/system-monitor',
        to: '/system-monitor/cache-monitor'
      }
    ]
  },
  {
    name: '仪表盘',
    icon: 'dashboard',
    group: '/dashboard',
    groupName: 'first',
    children: [
      {
        name: '分析页',
        group: '/dashboard',
        to: '/dashboard/analysis'
      },
      {
        name: '监控页',
        group: '/dashboard',
        to: '/dashboard/monitor'
      },
      {
        name: '工作台',
        group: '/dashboard',
        to: '/dashboard/workplace'
      }
    ]
  },
  {
    name: '表单页',
    icon: 'edit_road',
    group: '/form',
    groupName: 'first',
    children: [
      {
        name: '基础表单',
        group: '/form',
        to: '/form/basic-form'
      },
      {
        name: '分步表单',
        group: '/form',
        to: '/form/step-form'
      },
      {
        name: '高级表单',
        group: '/form',
        to: '/form/advanced-form'
      }
    ]
  },
  {
    name: '列表页',
    icon: 'table_view',
    group: '/list',
    groupName: 'first',
    children: [
      {
        name: '搜索列表',
        group: '/list/search',
        children: [
          {
            name: '搜索列表（文章）',
            group: '/list/search',
            to: '/list/search/articles'
          },
          {
            name: '搜索列表（项目）',
            group: '/list/search',
            to: '/list/search/projects'
          },
          {
            name: '搜索列表（应用）',
            group: '/list/search',
            to: '/list/search/applications'
          }
        ]
      },
      {
        name: '用户列表',
        group: '/list',
        to: '/list/user-list'
      },
      {
        name: '商品列表',
        group: '/list',
        to: '/list/goods-list'
      },
      {
        name: '查询表格',
        group: '/list',
        to: '/list/table-list'
      },
      {
        name: '标准列表',
        group: '/list',
        to: '/list/basic-list'
      },
      {
        name: '卡片列表',
        group: '/list',
        to: '/list/card-list'
      }
    ]
  },
  {
    name: '详情页',
    icon: 'library_books',
    group: '/profile',
    groupName: 'first',
    children: [
      {
        name: '基础详情页',
        group: '/profile',
        to: '/profile/basic'
      },
      {
        name: '高级详情页',
        group: '/profile',
        to: '/profile/advanced'
      }
    ]
  },
  {
    name: '结果页',
    icon: 'check_circle_outline',
    group: '/result',
    groupName: 'first',
    children: [
      {
        name: '成功页',
        group: '/result',
        to: '/result/success'
      },
      {
        name: '失败页',
        group: '/result',
        to: '/result/fail'
      }
    ]
  },
  {
    name: '异常页',
    icon: 'error_outline',
    group: '/exception',
    groupName: 'first',
    children: [
      {
        name: '403',
        group: '/exception',
        to: '/exception/403'
      },
      {
        name: '404',
        group: '/exception',
        to: '/exception/404'
      },
      {
        name: '500',
        group: '/exception',
        to: '/exception/500'
      }
    ]
  },
  {
    name: '个人页',
    icon: 'perm_identity',
    group: '/account',
    groupName: 'first',
    children: [
      {
        name: '个人中心',
        group: '/account',
        to: '/account/center'
      },
      {
        name: '个人设置',
        group: '/account',
        to: '/account/settings'
      }
    ]
  },
  {
    name: '编辑器',
    icon: 'text_fields',
    group: '/editor',
    groupName: 'first',
    children: [
      {
        name: '自定义编辑器',
        group: '/editor',
        to: '/editor/customer'
      },
      {
        name: 'Markdown编辑器',
        group: '/editor',
        to: '/editor/markdown'
      }
    ]
  }
]

function queryList(routeDatas, tabs) {
  for (let i = 0; i < routeDatas.length; i++) {
    const sonList = routeDatas[i].children
    if (!sonList || sonList.length === 0) {
      const routeData = routeDatas[i]
      routeData.active = false
      tabs.push(routeData)
    } else {
      queryList(sonList, tabs)
    }
  }
  return tabs
}

const allTabs = []
const accessTabs = []
queryList(routeDatas, allTabs)

const informsData = [
  {
    icon: 'email',
    title: '你推荐的 曲妮妮 已通过第三轮面试',
    desc: '3年前',
    color: 'orange',
    textColor: 'white',
    disable: false
  },
  {
    icon: 'bluetooth',
    title: '你收到了 14 份新周报',
    desc: '3年前',
    color: 'primary',
    textColor: 'white',
    disable: false
  },
  {
    icon: 'email',
    title: '这种模板可以区分多种通知类型',
    desc: '3年前',
    color: 'teal',
    textColor: 'white',
    disable: true
  },
  {
    icon: 'email',
    title: '左侧图标用于区分不同的类型',
    desc: '3年前',
    color: 'yellow-10',
    textColor: 'white',
    disable: false
  },
  {
    icon: 'email',
    title: '内容不要超过两行字，超出时自动截断',
    desc: '3年前',
    color: 'orange',
    textColor: 'white',
    disable: false
  }
]
const notifyDatas = [
  {
    icon: 'email',
    title: '你推荐的 曲妮妮 已通过第三轮面试',
    desc: '3年前',
    color: 'orange',
    textColor: 'white',
    disable: false
  },
  {
    icon: 'bluetooth',
    title: '你收到了 14 份新周报',
    desc: '3年前',
    color: 'primary',
    textColor: 'white',
    disable: false
  },
  {
    icon: 'email',
    title: '这种模板可以区分多种通知类型',
    desc: '3年前',
    color: 'teal',
    textColor: 'white',
    disable: true
  },
  {
    icon: 'email',
    title: '左侧图标用于区分不同的类型',
    desc: '3年前',
    color: 'yellow-10',
    textColor: 'white',
    disable: false
  },
  {
    icon: 'email',
    title: '内容不要超过两行字，超出时自动截断',
    desc: '3年前',
    color: 'orange',
    textColor: 'white',
    disable: false
  },
  {
    icon: 'email',
    title: '内容不要超过两行字，超出时自动截断222',
    desc: '3年前',
    color: 'blue',
    textColor: 'white',
    disable: false
  }
]
const waitDealDatas = [
  {
    icon: 'email',
    title: '你推荐的 曲妮妮 已通过第三轮面试',
    desc: '3年前',
    color: 'orange',
    textColor: 'white',
    disable: false
  },
  {
    icon: 'bluetooth',
    title: '你收到了 14 份新周报',
    desc: '3年前',
    color: 'primary',
    textColor: 'white',
    disable: false
  },
  {
    icon: 'email',
    title: '这种模板可以区分多种通知类型',
    desc: '3年前',
    color: 'teal',
    textColor: 'white',
    disable: true
  },
  {
    icon: 'email',
    title: '左侧图标用于区分不同的类型',
    desc: '3年前',
    color: 'yellow-10',
    textColor: 'white',
    disable: false
  },
  {
    icon: 'email',
    title: '内容不要超过两行字，超出时自动截断',
    desc: '3年前',
    color: 'orange',
    textColor: 'white',
    disable: false
  }
]
const languageDatas = [
  {
    nationalFlag:
      'imgs/language/us.jpg',
    label: 'Us English'
  },
  {
    nationalFlag:
      'imgs/language/en.jpg',
    label: 'En English'
  },
  {
    nationalFlag:
      'imgs/language/jiantizhongwen.jpg',
    label: 'CN 简体中文'
  },
  {
    nationalFlag:
      'imgs/language/fantizhongwen.jpg',
    label: 'HK 繁体中文'
  }
]
const scrollStyleData = {
  contentStyle: {},
  contentActiveStyle: {},
  thumbStyle: {
    right: '2px',
    borderRadius: '5px',
    backgroundColor: '#027be3',
    width: '0px',
    opacity: 0.75
  },
  barStyle: {
    right: '2px',
    borderRadius: '9px',
    backgroundColor: '#027be3',
    width: '9px',
    opacity: 0.2
  }
}

const rightOffset = {
  rightOffsetGithubInit: [5, 68],
  rightOffsetInit: [5, 168],
  rightOffsetShow: [280, 168]
}

const styleSettingsData = {
  themeColorSetting: [
    {
      style: 'background-color: rgb(24, 144, 255)',
      color: 'rgb(24, 144, 255)',
      checked: true
    },
    {
      style: 'background-color: rgb(245, 34, 45)',
      color: 'rgb(245, 34, 45)',
      checked: false
    },
    {
      style: 'background-color: rgb(250, 84, 28)',
      color: 'rgb(250, 84, 28)',
      checked: false
    },
    {
      style: 'background-color: rgb(250, 173, 20)',
      color: 'rgb(250, 173, 20)',
      checked: false
    },
    {
      style: 'background-color: rgb(19, 194, 194)',
      color: 'rgb(19, 194, 194)',
      checked: false
    },
    {
      style: 'background-color: rgb(82, 196, 26)',
      color: 'rgb(82, 196, 26)',
      checked: false
    },
    {
      style: 'background-color: rgb(47, 84, 235)',
      color: 'rgb(47, 84, 235)',
      checked: false
    },
    {
      style: 'background-color: rgb(114, 46, 209)',
      color: 'rgb(114, 46, 209)',
      checked: false
    }
  ],
  fixed: {
    viewHead: 'hHh',
    viewBody: 'LpR',
    viewFoot: 'lfr',
    fixedHead: true,
    fixedFooter: false
  },
  contentSettings: {
    header: true,
    topBar: true,
    topBarGlossy: false,
    footer: true,
    leftMenuHeader: true
  }
}

// 获取可用的数量
function getAvailableCount(datas) {
  if (!datas) {
    return 0
  }
  let count = 0
  for (let i = 0; i < datas.length; ++i) {
    if (datas[i].disable === false) {
      count++
    }
  }
  return count
}

function selectTabByTo(to) {
  for (let i = 0; i < allTabs.length; ++i) {
    if (allTabs[i].to === to) {
      return allTabs[i]
    }
  }
}

function addTab(to) {
  if (!to || to === '/') {
    to = '/dashboard/analysis'
  }

  console.log(to + '0000000000')
  let exist = false
  let currentTab = null
  for (let i = 0; i < accessTabs.length; ++i) {
    if (accessTabs[i].to === to) {
      exist = true
      currentTab = accessTabs[i]
    } else {
      accessTabs[i].active = false
    }
  }
  if (!exist) {
    currentTab = selectTabByTo(to)
    accessTabs.push(currentTab)
  }
  currentTab.active = true
  return currentTab
}

export default {
  routeDatas,
  informsData,
  waitDealDatas,
  notifyDatas,
  languageDatas,
  scrollStyleData,
  rightOffset,
  styleSettingsData,
  accessTabs,
  addTab,
  getAvailableCount,
  selectTabByTo
}
