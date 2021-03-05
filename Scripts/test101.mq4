#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
#include <CustomFunctions.mqh>

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
   // Alert("Is trade allowed #2: ", IsTradeAllowed(NULL, TimeCurrent()) ? "Allowed" : "Not allowed");
   
   // Check account type and minimum lot can be traded
   // Alert(SymbolInfoDouble(Symbol(), SYMBOL_TRADE_CONTRACT_SIZE));
   // Alert(MarketInfo(Symbol(), MODE_MINLOT));
   
   // Sending order
   // Alert("Account balance: ", AccountBalance());
   // Alert("Is trade allowed: ", IsTradeAllowed());
   // Alert("Point: ", _Point);
   
   //--- get minimum stop level
   double minstoplevel = MarketInfo(_Symbol, MODE_STOPLEVEL);
   // Alert("Minimum Stop Level=", minstoplevel, " points");
   double price = Ask;
   //--- calculated SL and TP prices must be normalized
   double stoploss = NormalizeDouble(Bid - minstoplevel * Point, Digits);
   double takeprofit = NormalizeDouble(Bid + minstoplevel * Point, Digits);
   //--- place market order to buy 1 lot
   /*
   int ticket = OrderSend(_Symbol, OP_BUYLIMIT, 0.1, Ask, 3, Ask - 100 * _Point, Ask + 150 * _Point, NULL, 0, 0, Green);
   // int ticket=OrderSend(Symbol(), OP_BUY, 0.1, price, 3, stoploss, takeprofit, "My order", 0 , 0, clrGreen);
   if (ticket < 0) {
     Alert("Order send failed with error #", GetLastError());
   } else {
     Alert("Order send successfully");
     Comment("Ticket: ", ticket);
   }
   */
   
   Alert("*** " + TimeLocal() + " ***");
   
   double maxLossPct = 0.02;
   int maxLossInPips = 40;
   
   Alert("Point: ", _Point);
   Alert("Ask: ", Ask);
   Alert("Stop loss: ", Ask - 400 * _Point);
   double optimalLotSize = OptimalLotSize(maxLossPct, Ask, Ask - 400 * _Point);  // 400 points = 40 pips
   
   // double optimalLotSize = OptimalLotSize(maxLossPct, maxLossInPips);
   Alert("Optimal Lot Size: ", optimalLotSize);
}
