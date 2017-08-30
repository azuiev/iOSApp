//
//  AZUserModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 14/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZUserModel.h"

#import "NSString+AZRandomName.h"

#import "AZRandomNumber.h"

static NSString   *kName        = @"kName";
static NSString   *kSurName     = @"kSurName";
static NSString   *kImageModel  = @"kImageModel";

static NSArray  *urls    = nil;

@interface AZUserModel ()
@property (nonatomic, strong) AZImageModel  *imageModel;

@end

@implementation AZUserModel

@dynamic fullName;

#pragma mark -
#pragma mark Initialization and Deallocation

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initURLs];
        
        NSString *urlName = urls[AZRandomNumberWithMaxValue(urls.count - 1)];
        
        self.name = [NSString randomName];
        self.surName = [NSString randomName];
        self.imageModel = [AZImageModel imageModelWithURL:[NSURL URLWithString:urlName]];
    }
    
    return self;
}

- (void)initURLs {
    if (!urls) {
        urls = @[@"https://upload.wikimedia.org/wikipedia/en/c/c6/NeoTheMatrix.jpg",
                 @"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSV_j76ZNzoezj8xC6WZRZ8krhlRxZ6iopPQ1BvDd6hhDh4nu7C",
                 @"https://s00.yaplakal.com/pics/pics_original/1/4/6/2207641.jpg",
                 @"http://www.gunaxin.com/wp-content/uploads/2013/04/Neo_Matrix1_h2-560x296.jpg",
                 @"https://vignette2.wikia.nocookie.net/powerlisting/images/b/bd/Neo_The_One.jpg/revision/latest",
                 @"http://shpil.com/shpil.com/wp-content/uploads/2016/08/film-the_matrix-1999-neo-keanu_reeves-accessories-neo_sunglasses.jpg",
                 @"http://i.playground.ru/i/20/31/50/00/news/icon.700xauto.jpg",
                 @"https://i.ytimg.com/vi/8_C0E1ml5-o/hqdefault.jpg"];
    }
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surName];
}

#pragma mark -
#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:kName];
        self.surName = [coder decodeObjectForKey:kSurName];
        self.imageModel = [coder decodeObjectForKey:kImageModel];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:kName];
    [coder encodeObject:self.surName forKey:kSurName];
    [coder encodeObject:self.imageModel forKey:kImageModel];
}

@end
