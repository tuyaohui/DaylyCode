//
//  TranscodeViewController.m
//  TestFFMpeg
//
//  Created by Apple on 16/6/21.
//  Copyright © 2016年 tuyaohui. All rights reserved.
//

#import "TranscodeViewController.h"
#import "ffmpeg.h"

@interface TranscodeViewController ()

@end

@implementation TranscodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.transcode addTarget:self action:@selector(transcodeAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)transcodeAction
{
    NSString *soucePath = [[NSBundle mainBundle]pathForResource:@"sintel.mov" ofType:nil];
    NSString *targetPath  = [NSString stringWithFormat:@"%@/Documents/test.avi",NSHomeDirectory()];
    
    NSLog(@"%@",targetPath);
    
    NSString *commond = [NSString stringWithFormat:@"ffmpeg -i %@ -b:v 400k -s 1280x640 %@",soucePath,targetPath];
    self.content.text = commond;
    
    NSArray *argv_array = [commond componentsSeparatedByString:@" "];
    int argc = (int)argv_array.count;
    char **argv = malloc(sizeof(char)*1024);
    //把我们写的命令转成c的字符串数组
    for (int i = 0; i < argc; i++) {
        argv[i] = (char *)malloc(sizeof(char)*1024);
        strcpy(argv[i], [[argv_array objectAtIndex:i] UTF8String]);
        
    }
    
    ffmpeg_main(argc, argv);
    
    for(int i=0;i<argc;i++)
        free(argv[i]);
    free(argv);
    
}


@end
