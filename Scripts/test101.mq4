#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs

// int maPeriod = 20;

// int bbPeriod = 20;
// int bbStdDev = 2;
// int bandShift = 1;

int rsiPeriod = 14;
int rsiShift = 0;

void OnStart(){
   // double maValue = iMA(NULL, 0, maPeriod, -3, MODE_SMA, PRICE_CLOSE, 4);
   // Alert("MA 20 is " + NormalizeDouble(maValue, Digits) + ".");
   
   // double bbLowerValue = iBands(NULL, 0, bbPeriod, bbStdDev, bandShift, PRICE_CLOSE, MODE_LOWER, 0);
   // double bbUpperValue = iBands(NULL, 0, bbPeriod, bbStdDev, bandShift, PRICE_CLOSE, MODE_UPPER, 0);
   // double bbMainValue = iBands(NULL, 0, bbPeriod, bbStdDev, bandShift, PRICE_CLOSE, MODE_MAIN, 0);
   // Alert("BB Upper value is " + NormalizeDouble(bbUpperValue, Digits) + ".");
   // Alert("BB Main value is " + NormalizeDouble(bbMainValue, Digits) + ".");
   // Alert("BB Lower value is " + NormalizeDouble(bbLowerValue, Digits) + ".");

   // double currentRsi = iRSI(NULL, PERIOD_CURRENT, rsiPeriod, PRICE_CLOSE, rsiShift);
   // double prevRsi = iRSI(NULL, PERIOD_CURRENT, rsiPeriod, PRICE_CLOSE, rsiShift + 1);
   // Alert("Current RSI value is " + NormalizeDouble(currentRsi, 2) + ".");
   // Alert("Previous RSI value is " + NormalizeDouble(prevRsi, 2) + ".");

   // Alert("Is trade allowed #1: ", IsTradeAllowed());
   Alert("Is trade allowed #2: ", IsTradeAllowed(NULL, TimeCurrent()) ? "Allowed" : "Not allowed");
}
