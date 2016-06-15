//
//  ViewController.m
//  comera
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "newTableViewCell.h"
#import "xiangji.h"

@interface ViewController ()
<
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSFileManager *fileManger;
@property (nonatomic, strong) NSData *comeradata;
@end

@implementation ViewController
- (NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray new];
    }
    return _array;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    newTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[newTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    //系统相机
    cell.headimage.image = [UIImage imageWithContentsOfFile:self.array[indexPath.row]];
    //自定义相机
//    cell.headimage.image = self.array[indexPath.row];
    
    
    return cell;
}


- (IBAction)paizhao:(id)sender {
    /**
     
     调用自定义相机
     */
    xiangji *vc = [[xiangji alloc] init];
    
    
    vc.xiangjiHUI = ^(NSData *data,UIImage *image){
        self.data = data;
        self.image = image;
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        
        
        NSString *stringtime = [NSString stringWithFormat:@"/+%ld.png",time(NULL)];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [self.fileManger createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [self.fileManger createFileAtPath:[DocumentsPath stringByAppendingString:stringtime] contents:self.data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",DocumentsPath,stringtime];
        [self.array addObject:filePath];
        [self.tableview reloadData];
        [vc dismissViewControllerAnimated:YES completion:nil];
        
    };
    [self presentViewController:vc animated:YES completion:nil];
//
    
    
    
    /**
     *  调用系统相机
     */
//    UIImagePickerControllerSourceType sourcetype = UIImagePickerControllerSourceTypeCamera;
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    picker.sourceType = sourcetype;
//    picker.allowsEditing = YES;
//    [self presentViewController:picker animated:YES completion:nil];

}
#pragma mark UINavigationControllerDelegate && UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"拍照完成的回调");
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        @autoreleasepool {
            self.comeradata = UIImagePNGRepresentation(image);
            
            //图片保存的路径
            //这里将图片放在沙盒的documents文件夹中
            NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            
            
            
            NSString *stringtime = [NSString stringWithFormat:@"/+%ld.png",time(NULL)];
            
            //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
            [self.fileManger createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
            [self.fileManger createFileAtPath:[DocumentsPath stringByAppendingString:stringtime] contents:self.comeradata attributes:nil];
            
            //得到选择后沙盒中图片的完整路径
            NSString *filePath = [NSString stringWithFormat:@"%@%@",DocumentsPath,stringtime];
            [self.array addObject:filePath];
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableview reloadData];
            [picker dismissViewControllerAnimated:YES completion:nil];
        });
    });
    

}

- (NSFileManager *)fileManger
{
    if (!_fileManger) {
        _fileManger = [NSFileManager defaultManager];
        
    }
    return _fileManger;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
