//
//  AMapPolygon.m
//  amap_map
//
//  Created by lly on 2020/11/12.
//

#import "AMapPolygon.h"
#import "AMapConvertUtil.h"
#import "MAPolygon+Flutter.h"

@interface AMapPolygon ()

@property (nonatomic, strong,readwrite) MAPolygon *polygon;

@end


@implementation AMapPolygon

- (instancetype)init {
    self = [super init];
    if (self) {
        _visible = YES;
    }
    return self;
}

- (void)postHookWith:(NSDictionary *)dict {
    NSArray *points = dict[@"points"];
    NSAssert(points.count > 0, @"polygon传入的经纬度点有误！");
    //如果经纬度点已经有值，需要手动释放内存
    if (_coords != NULL) {
        free(_coords);
        _coords = NULL;
    }
    _coordCount = points.count;
    _coords = (CLLocationCoordinate2D*)malloc(_coordCount * sizeof(CLLocationCoordinate2D));
    for (NSUInteger index = 0; index < _coordCount; index ++) {
        NSArray *point = points[index];
        _coords[index] = [AMapConvertUtil coordinateFromArray:point];
    }
}

- (void)dealloc {
    if (_coords != NULL) {
        free(_coords);
        _coords = NULL;
    }
}

- (MAPolygon *)polygon {
    if (_polygon == nil) {
        _polygon = [[MAPolygon alloc] initWithPolygonId:self.id_];
        [_polygon setPolygonWithCoordinates:_coords count:_coordCount];
    }
    return _polygon;
}

//更新polyline
- (void)updatePolygon:(AMapPolygon *)polygon {
    NSAssert((polygon != nil && [self.id_ isEqualToString:polygon.id_]), @"更新AMapPolygon数据异常");
    if ([self checkCoordsEqualWithPolyline:polygon] == NO) {//polyline更新了经纬度坐标
        if (_coords != NULL) {
            free(_coords);
            _coords = NULL;
        }
        _coordCount = polygon->_coordCount;
        _coords = (CLLocationCoordinate2D*)malloc(_coordCount * sizeof(CLLocationCoordinate2D));
        for (NSUInteger index = 0; index < _coordCount; index ++) {
            _coords[index] = polygon->_coords[index];
        }
    }
    self.strokeWidth = polygon.strokeWidth;
    self.strokeColor = polygon.strokeColor;
    self.fillColor = polygon.fillColor;
    self.visible = polygon.visible;
    self.joinType = polygon.joinType;
    if (_polygon) {
        [_polygon setPolygonWithCoordinates:_coords count:_coordCount];
    }
}

- (BOOL)checkCoordsEqualWithPolyline:(AMapPolygon *)newPolygon {
    if (_coordCount != newPolygon->_coordCount) {//数量不同，则直接更新
        return NO;
    }
    for (NSUInteger index = 0; index < _coordCount; index++) {
        if ([AMapConvertUtil isEqualWith:_coords[index] to:newPolygon->_coords[index]] == NO) {
            return NO;
        }
    }
    return YES;
}


@end
