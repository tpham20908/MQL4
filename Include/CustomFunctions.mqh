#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

double GetPipValue() {
   if (Digits >= 4) {
      return 0.0001;
   } else {
      return 0.01;
   }
}

double CalculateStopLoss(bool isLong, double entryPrice, int pips) {
   double stopLoss;
   if (isLong) {
      stopLoss = entryPrice - pips * GetPipValue();
   } else {
      stopLoss = entryPrice + pips * GetPipValue();
   }
   return stopLoss;
}

double CalculateTakeProfit(bool isLong, double entryPrice, int pips) {
   double takeProfit;
   if (isLong) {
      takeProfit = entryPrice + pips * GetPipValue();
   } else {
      takeProfit = entryPrice - pips * GetPipValue();
   }
   return takeProfit;
}