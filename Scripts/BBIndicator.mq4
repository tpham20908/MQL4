#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <CustomFunctions.mqh>

int bbPeriod = 20;
int stdDev1 = 1;
int stdDev4 = 4;

void OnStart() {
   Alert("Starting...");
   double bbMain = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev1, 0, PRICE_CLOSE, MODE_MAIN, 0);
   double bbLower1 = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev1, 0, PRICE_CLOSE, MODE_LOWER, 0);
   double bbUpper1 = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev1, 0, PRICE_CLOSE, MODE_UPPER, 0);
   double bbLower4 = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev4, 0, PRICE_CLOSE, MODE_LOWER, 0);
   double bbUpper4 = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev4, 0, PRICE_CLOSE, MODE_UPPER, 0);

   if(Ask < bbLower1) { //buying
      Alert("Price is bellow bbLower1, Sending buy order...");
      double stopLossPrice = bbLower4;
      double takeProfitPrice = bbMain;

      Alert("Entry Price = " + Ask);
      Alert("Stop Loss Price = " + stopLossPrice);
      Alert("Take Profit Price = " + takeProfitPrice);
   } else if(Bid > bbUpper1) { //shorting
      Alert("Price is above bbLower1, Sending short order...");
      double stopLossPrice = bbUpper4;
      double takeProfitPrice = bbMain;

      Alert("Entry Price = " + Bid);
      Alert("Stop Loss Price = " + stopLossPrice);
      Alert("Take Profit Price = " + takeProfitPrice);
   }
   
   Alert("Error code: ", GetLastError());
}
