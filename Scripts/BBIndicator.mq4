#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
#include <CustomFunctions.mqh>

int bbPeriod = 20;
int stdDev1 = 1;
int stdDev4 = 4;

input double maxLossPercentage = 0.02;
input int stopLossInPoints = 400;  // 40 pips
input int takeProfitInPoints = 600;  // 60 pips

void OnStart() {
   int orderId;
   double bbMain = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev1, 0, PRICE_CLOSE, MODE_MAIN, 0);
   double bbLower1 = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev1, 0, PRICE_CLOSE, MODE_LOWER, 0);
   double bbUpper1 = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev1, 0, PRICE_CLOSE, MODE_UPPER, 0);
   // double bbLower4 = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev4, 0, PRICE_CLOSE, MODE_LOWER, 0);
   // double bbUpper4 = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev4, 0, PRICE_CLOSE, MODE_UPPER, 0);
   double lotSize; 
   double stopLossPrice;
   double takeProfitPrice;

   if(Ask < bbLower1) { //buying
      Print("Price is bellow bbLower1, Sending buy order...");
      // stopLossPrice = bbLower4;
      // takeProfitPrice = bbMain;
      stopLossPrice = Ask - stopLossInPoints * _Point;
      takeProfitPrice = Ask + takeProfitInPoints * _Point;
      lotSize = OptimalLotSize(maxLossPercentage, Ask, stopLossPrice);

      Print("Entry Price = " + Ask);
      Print("Stop Loss Price = " + stopLossPrice);
      Print("Take Profit Price = " + takeProfitPrice);
      
      orderId = OrderSend(_Symbol, OP_BUYLIMIT, lotSize, Ask, 10, stopLossPrice, takeProfitPrice, "Buying...", 0, 0, clrBeige);
   } else if(Bid > bbUpper1) { //shorting
      Print("Price is above bbLower1, Sending short order...");
      // stopLossPrice = bbUpper4;
      // takeProfitPrice = bbMain;
      stopLossPrice = Bid + stopLossInPoints * _Point;
      takeProfitPrice = Bid - takeProfitInPoints * _Point;
      lotSize = OptimalLotSize(maxLossPercentage, Bid, stopLossPrice);

      Print("Entry Price = " + Bid);
      Print("Stop Loss Price = " + stopLossPrice);
      Print("Take Profit Price = " + takeProfitPrice);
      
      orderId = OrderSend(_Symbol, OP_SELLLIMIT, lotSize, Bid, 10, stopLossPrice, takeProfitPrice, "Shorting...", 0, 0, clrCadetBlue);
   }
   
   Alert("*** " + TimeLocal() + " ***");
   Alert(orderId < 0 ? "Order sent failed, error code: " + GetLastError() : "Order sent successfully! See prints for more details.");
   Print("Lot size: ", lotSize);
}
