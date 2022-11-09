#import "Helper.h"

#if !defined(SWIFT_PACKAGE)
@interface WPXMLRPCAssetsBundleFinder: NSObject
@end

@implementation WPXMLRPCAssetsBundleFinder
@end
#endif

@implementation NSBundle (Helper)

+ (NSBundle *)wpxmlrpc_assetsBundle {
#if SWIFT_PACKAGE
    return SWIFTPM_MODULE_BUNDLE;
#else
    return [NSBundle bundleForClass:[WPXMLRPCAssetsBundleFinder class]];
#endif
}

@end
