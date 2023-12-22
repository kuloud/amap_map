//
//  AMapPolyline.m
//  amap_map
//
//  Created by lly on 2020/11/6.
//

#import "AMapPolyline.h"
#import "AMapConvertUtil.h"
#import "MAPolyline+Flutter.h"

@interface AMapPolyline ()

@property (nonatomic, strong, readwrite) MAPolyline *polyline;

@end


@implementation AMapPolyline

- (instancetype)init {
    self = [super init];
    if (self) {
        _alpha = 1.0;
        _visible = YES;
    }
    return self;
}

- (void)postHookWith:(NSDictionary *)dict {
    NSArray *points = dict[@"points"];
    NSAssert(points.count > 0, @"polyline传入的经纬度点有误！");
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

- (MAPolyline *)polyline {
    if (_polyline == nil) {
        if (self.geodesic) {//如果是大地曲线，则使用对应的类型
            _polyline = [[MAGeodesicPolyline alloc] initWithPolylineId:self.id_];
        } else {        
            _polyline = [[MAPolyline alloc] initWithPolylineId:self.id_];
        }
        [_polyline setPolylineWithCoordinates:_coords count:_coordCount];
    }
    return _polyline;
}

- (void)dealloc {
    if (_coords != NULL) {
        free(_coords);
        _coords = NULL;
    }
}

//更新polyline
- (void)updatePolyline:(AMapPolyline *)polyline {
    NSAssert((polyline != nil && [self.id_ isEqualToString:polyline.id_]), @"更新Polyline数据异常");
    if ([self checkCoordsEqualWithPolyline:polyline] == NO) {//polyline更新了经纬度坐标
        if (_coords != NULL) {
            free(_coords);
            _coords = NULL;
        }
        _coordCount = polyline->_coordCount;
        _coords = (CLLocationCoordinate2D*)malloc(_coordCount * sizeof(CLLocationCoordinate2D));
        for (NSUInteger index = 0; index < _coordCount; index ++) {
            _coords[index] = polyline->_coords[index];
        }
    }
    self.width = polyline.width;
    self.color = polyline.color;
    self.visible = polyline.visible;
    self.alpha = polyline.alpha;
    NSAssert(self.geodesic == polyline.geodesic, @"是否为大地曲线的变量，不允许动态修改");
    self.dashLineType = polyline.dashLineType;
    self.joinType = polyline.joinType;
    self.capType = polyline.capType;
    if (_polyline) {
        [_polyline setPolylineWithCoordinates:_coords count:_coordCount];
    }
}

- (BOOL)checkCoordsEqualWithPolyline:(AMapPolyline *)newPolyline {
    if (_coordCount != newPolyline->_coordCount) {//数量不同，则直接更新
        return NO;
    }
    for (NSUInteger index = 0; index < _coordCount; index++) {
        if ([AMapConvertUtil isEqualWith:_coords[index] to:newPolyline->_coords[index]] == NO) {
            return NO;
        }
    }
    return YES;
}

@end
