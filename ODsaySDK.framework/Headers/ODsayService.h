//
//  ODsayService.h
//  ODsaySDK
//
//  Created by SEONG HOON CHOI on 2017. 9. 11..
//  Copyright © 2017년 SEONG HOON CHOI. All rights reserved.
//

#import <Foundation/Foundation.h>

/////////////// -------   Response Block  ------------------------------------------------------------
typedef void (^ResponseBlock)(int retCode, NSDictionary *resultDic);
//////////////  --------------------------------------------------------------------------------------

@interface ODsayService : NSObject

+ (ODsayService *)sharedInst;
+ (void)releaseInst;

- (void)setApiKey:(NSString*)sApiKey;
- (void)setTimeout:(int)mSec;

- (NSDictionary*)getLastReqParams;

//////////////////////////////////////////////////
// 버스노선 리스트를 요청합니다.
// @param busNo         조회할 버스노선번호
// @param cid           도시코드
// @param stationListYn 주요정류장 표현 옵션
// @param displayCnt    리턴 결과 개수
// @param startNo       결과 개수 중 시작번호
//////////////////////////////////////////////////
- (void)requestSearchBusLane:(NSString*)busNo
                         cid:(int)cid
               stationListYn:(NSString*)stationListYn
                  displayCnt:(int)displayCnt
                     startNo:(int)startNo
               responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 특정 버스노선의 운행경로에 대한 정보를 요청합니다.
// @param busID 운행경로를 조회할 버스노선코드
//////////////////////////////////////////////////
- (void)requestBusLaneDetail:(NSString*)busID
               responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 특정 버스정류장의 정보를 요청합니다.
// @param stationID 정류장 정보를 조회할 정류장코드
//////////////////////////////////////////////////
- (void)requestBusStationInfo:(NSString*)stationID
                responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 열차·KTX 운행정보를 요청합니다.
// @param startStationID 역 ID
// @param endStationID   역 ID
//////////////////////////////////////////////////
- (void)requestTrainServiceTime:(NSString*)startStationID
                   endStationID:(NSString*)endStationID
                  responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 고속버스 운행정보를 요청합니다.
// @param startStationID 터미널 ID
// @param endStationID   터미널 ID
//////////////////////////////////////////////////
- (void)requestExpressServiceTime:(NSString*)startStationID
                     endStationID:(NSString*)endStationID
                    responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 시외버스 운행정보를 요청합니다.
// @param startStationID 터미널 ID
// @param endStationID   터미널 ID
//////////////////////////////////////////////////
- (void)requestIntercityServiceTime:(NSString*)startStationID
                       endStationID:(NSString*)endStationID
                      responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 항공 운행정보를 요청합니다.
// @param startStationID 출발 공항 ID
// @param endStationID   도착 공항 ID
// @param selectTime     출발시간 default = 6
//////////////////////////////////////////////////
- (void)requestAirServiceTime:(NSString*)startStationID
                 endStationID:(NSString*)endStationID
                   selectTime:(int)selectTime
                responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 운수회사별 버스노선를 요청합니다.
// @param companyID 조회할 운수회사 ID
// @param busNo     조회할 버스노선번호
//////////////////////////////////////////////////
- (void)requestSearchCompanyLane:(NSString*)companyID
                           busNo:(NSString*)busNo
                   responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 지하철역 세부 정보를 리턴합니다.
// @param stationID 지하철 역 정보를 조회 할 역코드
//////////////////////////////////////////////////
- (void)requestSubwayStationInfo:(NSString*)stationID
                   responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 지하철역 전체 시간표를 요청합니다.
// @param stationID 지하철 역 정보를 조회 할 역코드
// @param wayCode   지하철역 방면 코드	(1:상행, 2:하행)
//////////////////////////////////////////////////
- (void)requestSubwayTimeTable:(NSString*)stationID
                       wayCode:(int)wayCode
                 responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 구간에 대한 노선 경로 정보를 요청합니다.
// @param mapObject 경로를 조회할 코드
//////////////////////////////////////////////////
- (void)requestLoadLane:(NSString*)mapObject
          responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 대중교통 정류장 세부정보를 요청합니다.
// @param stationName  정류장을 검색 할 이름(2자 이상)
// @param cid           도시코드
// @param stationClass 정류장 종류(여러 개 선택 가능)
// @param displayCnt   리턴 결과 개수
// @param startNO      결과 개수 중 시작번호
// @param myLocation   현위치 좌표
//////////////////////////////////////////////////
- (void)requestSearchStation:(NSString*)stationName
                         cid:(int)cid
                stationClass:(NSString*)stationClass
                  displayCnt:(int)displayCnt
                     startNo:(int)startNo
                  myLocation:(NSString*)myLocation
               responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 지정된 포인트와 반경을 가지고 대중교통 POI정보를 검색합니다.
// @param x            x좌표(경위도)
// @param y            y좌표(경위도)
// @param radius       반경(m)
// @param stationClass 정류장 종류
//////////////////////////////////////////////////
- (void)requestPointSearch:(float)x
                         y:(float)y
                    radius:(int)radius
              stationClass:(NSString*)stationClass
             responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 지정된 영역내 대중교통 POI정보를 검색합니다.
// @param param        영역 좌표 (left:top:right:bottom)	(경위도)
// @param eparam       제외시킬 영역좌표(left:top:right:bottom)	(경위도)
// @param stationClass 정류장 종류(여러 개 선택 가능)
//////////////////////////////////////////////////
- (void)requestBoundarySearch:(NSString*)param
                       eparam:(NSString*)eparam
                 stationClass:(NSString*)stationClass
                responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 지하철역 전체 시간표 정보를 리턴합니다.(급행시각포함)
// @param cid  도시코드
// @param sid  출발역 코드
// @param eid  도착역 코드
// @param sopt 경로검색 조건(default=1)	(1:최단거리, 2:최소환승)
//////////////////////////////////////////////////
- (void)requestSubwayPath:(int)cid
                      sid:(int)sid
                      eid:(int)eid
                     sopt:(int)sopt
            responseBlock:(ResponseBlock)responseBlock;


//////////////////////////////////////////////////
// 대중교통 길찾기 정보를 리턴합니다.
// @param sx             출발지 X좌표 (경도좌표)
// @param sy             출발지 Y좌표 (위도좌표)
// @param ex             도착지 X좌표 (경도좌표)
// @param ey             도착지 Y좌표 (위도좌표)
// @param opt            경로검색결과 정렬방식	0: 최단거리, 1 타입별정렬
// @param searchType     도시간 이동/도시내 이동을 선택한다.
// @param searchPathType 도시 내 경로수단을 지정한다.
//////////////////////////////////////////////////
- (void)requestSearchPubTransPath:(NSString*)sx
                               sy:(NSString*)sy
                               ex:(NSString*)ex
                               ey:(NSString*)ey
                              opt:(int)opt
                       searchType:(int)searchType
                   searchPathType:(int)searchPathType
                    responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 지하철역 환승 정보를 리턴합니다.
// @param stationID 지하철 환승 정보를 조회 할 역코드
//////////////////////////////////////////////////
- (void)requestSubwayTransitInfo:(NSString*)stationID
                   responseBlock:(ResponseBlock)responseBlock;


//////////////////////////////////////////////////
// 고속버스 터미널 정보를 리턴합니다.
// @param cid          도시코드
// @param terminalName 터미널명
//////////////////////////////////////////////////
- (void)requestExpressBusTerminals:(int)cid
                      terminalName:(NSString*)terminalName
                     responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 시외버스 터미널 정보를 리턴합니다.
// @param cid          도시코드
// @param terminalName 터미널명
//////////////////////////////////////////////////
- (void)requestIntercityBusTerminals:(int)cid
                        terminalName:(NSString*)terminalName
                       responseBlock:(ResponseBlock)responseBlock;

//////////////////////////////////////////////////
// 도시코드(CID)를 리턴합니다.
// @param cityName 조회할 도시이름(한글)
//////////////////////////////////////////////////
- (void)requestSearchCID:(NSString*)cityName
           responseBlock:(ResponseBlock)responseBlock;

@end
