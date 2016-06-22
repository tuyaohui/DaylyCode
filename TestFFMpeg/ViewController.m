//
//  ViewController.m
//  TestFFMpeg
//
//  Created by Apple on 16/6/20.
//  Copyright © 2016年 tuyaohui. All rights reserved.
//

#import "ViewController.h"
#import "libavformat/avformat.h"
#import "avcodec.h"
#import "avfilter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    av_register_all();
    char info[10000] = { 0 };
    printf("%s\n", avcodec_configuration());
    sprintf(info, "%s\n", avcodec_configuration());
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    self.content.text=info_ns;
    
}


//FFMpeg协议信息
- (IBAction)protocolAction:(id)sender {
    
    char info[40000] = {0};
    av_register_all();
    
    struct URLProtocol *pup = NULL;
    
    //输入
    struct URLProtocol **p_temp = &pup;
    avio_enum_protocols((void **)p_temp,0);
    
    //将输入信息写到字符串里
    while ((*p_temp) != NULL) {
        sprintf(info, "%s[In][%10s] -- ",info,avio_enum_protocols((void **)p_temp,0) );
    }
    pup = NULL;
    
    //输出 1为输出 其他为输入
    avio_enum_protocols((void **)p_temp,1);
    while ((*p_temp) != NULL){
        sprintf(info, "%s[Out][%10s] -- ", info, avio_enum_protocols((void **)p_temp, 1));
    }
    //将输出信息写到字符串里
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    self.content.text=info_ns;

    
}

//FFMpeg能转码的输入输出格式
- (IBAction)avformatAction:(id)sender {
   
    char info[40000] = { 0 };
    
    av_register_all();
    
    AVInputFormat *if_temp = av_iformat_next(NULL);
    AVOutputFormat *of_temp = av_oformat_next(NULL);
    //Input  循环遍历输入信息，拿到输入 name属性
    while(if_temp!=NULL){
        sprintf(info, "%s[In ]%s - ", info, if_temp->name);
        if_temp=if_temp->next;
    }
    //Output  循环遍历输入信息，拿到输出 name属性
    while (of_temp != NULL){
        sprintf(info, "%s[Out]%s - ", info, of_temp->name);
        of_temp = of_temp->next;
    }
    //printf("%s", info);
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    self.content.text=info_ns;
}


- (IBAction)avcodecAction:(id)sender {
    
    char info[40000] = { 0 };
    
    av_register_all();
    
    AVCodec *c_temp = av_codec_next(NULL);
    
    while(c_temp!=NULL){
        if (c_temp->decode!=NULL){
            sprintf(info, "%s[Dec]", info);
        }
        else{
            sprintf(info, "%s[Enc]", info);
        }
        switch (c_temp->type){
            case AVMEDIA_TYPE_VIDEO:
                sprintf(info, "%s[Video]", info);
                break;
            case AVMEDIA_TYPE_AUDIO:
                sprintf(info, "%s[Audio]", info);
                break;
            default:
                sprintf(info, "%s[Other]", info);
                break;
        }
        sprintf(info, "%s%10s -- ", info, c_temp->name);
        
        
        c_temp=c_temp->next;
    }
    //printf("%s", info);
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    self.content.text=info_ns;

    
}

- (IBAction)avfilterAction:(id)sender {
    
    /*  crash
    char info[40000] = { 0 };
    avfilter_register_all();
    AVFilter *f_temp = (AVFilter *)avfilter_next(NULL);
    while (f_temp != NULL){
        sprintf(info, "%s[%10s]\n", info, f_temp->name);
    }
    //printf("%s", info);
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    self.content.text=info_ns;
     */
}

- (IBAction)configure:(id)sender {
    
    char info[10000] = { 0 };
    av_register_all();
    
    sprintf(info, "%s\n", avcodec_configuration());
    
    //printf("%s", info);
    //self.content.text=@"Lei Xiaohua";
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    self.content.text=info_ns;
    
}



@end
