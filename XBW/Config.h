//
//  Config.h
//  xmpptest
//
//  Created by yzl on 14-8-19.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#ifndef xmpptest_Config_h
#define xmpptest_Config_h

//    系统控件的默认高度
#define kStatusBarHeight   (20.f)
#define kTopBarHeight      (44.f)
#define kBottomBarHeight   (49.f)

//系统
#define Sys_Version [[UIDevice currentDevice].systemVersion doubleValue]
#define Sys_Name [[UIDevice currentDevice] systemName]


// App Frame Height&Width
#define Application_Frame  [[UIScreen mainScreen] applicationFrame] //除去信号区的屏幕的frame
#define APP_Frame_Height   [[UIScreen mainScreen] applicationFrame].size.height //应用程序的屏幕高度
#define App_Frame_Width    [[UIScreen mainScreen] applicationFrame].size.width  //应用程序的屏幕宽度
/*** MainScreen Height Width */

#define Main_Screen_Frame  [[UIScreen mainScreen] bounds]
#define Main_Screen_Height [[UIScreen mainScreen] bounds].size.height //主屏幕的高度
#define Main_Screen_Width  [[UIScreen mainScreen] bounds].size.width  //主屏幕的宽度



/**** MainView Frame *****/
#define Main_View_Frame (self.view.frame)

#define kIphone4Width 320
#define kIphone5Width 320

#define kIphone4Height 480
#define kIphone5Height 568

#define DocumentsDir [NSHomeDirectory() stringByAppendingString:@"/Documents"]

#endif
