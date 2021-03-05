#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

double OptimalLotSize(double maxLossPct, int maxLossInPips) {
   double accEquity = AccountEquity();
   int lotSize = MarketInfo(_Symbol, MODE_LOTSIZE);
   double tickValue = MarketInfo(_Symbol, MODE_TICKVALUE);
   tickValue = Digits <= 3 ? tickValue / 100 : tickValue;  // If currency quote is less than 3 decimal, get 5 decimal digits
   double maxLossDollar = accEquity * maxLossPct;
   double maxLossInQuoteCurrency = maxLossDollar / tickValue;
   double optimalLotSize = maxLossInQuoteCurrency / (maxLossInPips * GetPipValue()) / lotSize;
   optimalLotSize = NormalizeDouble(optimalLotSize, 2);
   
   return optimalLotSize;
}

double OptimalLotSize(double maxLossPct, double entryPrice, double stopLoss) {
   int maxLossInPips = MathAbs(entryPrice - stopLoss) / GetPipValue();
   
   return OptimalLotSize(maxLossPct, maxLossInPips);
}

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