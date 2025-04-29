//
//  UIImage+Extension.h
//  TenTenTen
//
//  Created by Lior Shabo on 05/04/2016.
//  Copyright © 2016 Lior Shabo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)imageWithImage:(UIImage *)image cropInRect:(CGRect)rect;
+ (UIImage *)imageWithImage:(UIImage *)image cropInRelativeRect:(CGRect)rect;
+ (UIImage*)mergeImage:(UIImage*)first withImage:(UIImage*)second;
+ (UIImage *)imageToGreyImage:(UIImage *)image;
+ (UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width;
+ (CGSize)imageWithSize:(CGSize)size scaledToMaxWidth:(CGFloat)width maxHeight:(CGFloat)height;

@end
