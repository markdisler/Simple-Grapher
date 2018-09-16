//
//  CCGraphableFunction.h
//  CapCalc Pro
//
//  Created by Mark on 6/28/16.
//  Copyright © 2016 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CCGraphableFunction : NSObject

/* Methods */

/*!
 * @brief Create a graphable function object that stores all information needed to graph something.
 * @param function The equation string to graph.
 */
- (id)initWithFunction:(NSString *)function;

/*!
 * @brief Clear out the array of input tokens.
 */
- (void)clearInputTokens;

/*!
 * @brief Clear out the array of scaled coordinates.
 */
- (void)clearScaledCoordinates;

/*!
 * @brief Clear the bezier path.
 */
- (void)clearPath;

/*!
 * @brief Clear out the array of raw coordinates.
 */
- (void)clearRawCoordinates;

/*!
 * @brief Reset this object to allow coordinates to be recalculated.
 */
- (void)resetGraphableFunction;


/* Properties */

/*! An array of the input tokens for the current equation. */
@property (nonatomic, strong) NSMutableArray *functionInputTokens;

/*! The string containing the equation to graph. */
@property (nonatomic, strong) NSString *functionString;

/*! Hex color string to use as the color of the graphed line. */
@property (nonatomic, strong) NSString *functionHexColor;

/*! Scaled coordinates in terms of the position in the graph view frame. */
@property (nonatomic, strong) NSMutableArray *scaledCoordinates;

/*! Coordinates in their raw form – the coordinates as calculated when passed through the function parser. */
@property (nonatomic, strong) NSMutableArray *rawCoordinates;

/*! The path that is drawn on screen to represent the function. */
@property (nonatomic, strong) UIBezierPath *path;

/*! Whether or not this function will be graphed with a minimum domain restriction. */
@property (nonatomic, assign) BOOL minDomainRestrictionExists;

/*! Whether or not this function will be graphed with a maximum domain restriction. */
@property (nonatomic, assign) BOOL maxDomainRestrictionExists;

/*! The value of the minimum domain restriction (left bound) of the graph that will only be used if there is a min domain restriction. */
@property (nonatomic, assign) double domainMinRestriction;

/*! The value of the maximum domain restriction (right bound) of the graph that will only be used if there is a max domain restriction. */
@property (nonatomic, assign) double domainMaxRestriction;

@end
