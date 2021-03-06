//--- This strategy has dynamic TP value = bbMain

#property strict
#property show_inputs
#include <CustomFunctions.mqh>

input double maxLossPercentage = 0.02;
input int stopLossInPoints = 40;  // 4 pips
input int takeProfitInPoints = 60;  // 6 pips
int bbPeriod = 20;
int stdDev1 = 1;
int magicNumber = 102;
int orderId = 0;

int OnInit() { return INIT_SUCCEEDED; }
void OnDeinit(const int reason) {}

void OnTick() {
   double bbMain = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev1, 0, PRICE_CLOSE, MODE_MAIN, 0);
   double bbLower1 = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev1, 0, PRICE_CLOSE, MODE_LOWER, 0);
   double bbUpper1 = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev1, 0, PRICE_CLOSE, MODE_UPPER, 0);
   double lotSize; 
   double stopLossPrice;
   double takeProfitPrice = bbMain;
   
   if (!CheckIfOpenOrderByMagicNumber(magicNumber)) { // try to get a position
      if(Ask < bbLower1) { //buying
         stopLossPrice = Ask - stopLossInPoints * _Point;
         lotSize = OptimalLotSize(maxLossPercentage, Ask, stopLossPrice);
   
         Print("Entry Price = " + Ask);
         Print("Stop Loss Price = " + stopLossPrice);
         Print("Take Profit Price = " + takeProfitPrice);
         
         orderId = OrderSend(_Symbol, OP_BUYLIMIT, lotSize, Ask, 10, stopLossPrice, takeProfitPrice, "Buying...", magicNumber, 0, clrBeige);
      } else if(Bid > bbUpper1) { //shorting
         stopLossPrice = Bid + stopLossInPoints * _Point;
         lotSize = OptimalLotSize(maxLossPercentage, Bid, stopLossPrice);
   
         Print("Entry Price = " + Bid);
         Print("Stop Loss Price = " + stopLossPrice);
         Print("Take Profit Price = " + takeProfitPrice);
         
         orderId = OrderSend(_Symbol, OP_SELLLIMIT, lotSize, Bid, 10, stopLossPrice, takeProfitPrice, "Shorting...", magicNumber, 0, clrCadetBlue);
      }
      
      Print("*** " + TimeLocal() + " ***");
      Print(orderId < 0 ? "Order sent failed, error code: " + GetLastError() : "Order sent successfully! See prints for more details.");
   } else { // there has already been a position, update order if needed
      double currentSLPrice = OrderStopLoss();
      double currentTPPrice = OrderTakeProfit();
      double currentPrice = OrderOpenPrice();
      double newSLPrice;
      double newTPPrice;
      if (OrderSelect(orderId, SELECT_BY_TICKET)) {
         int orderType = OrderType(); // 0 = long, 1 = short
         // newSLPrice = orderType == 0 ? currentSLPrice + _Point : currentSLPrice - _Point; // only for testing, shouldn't change SL
         // newTPPrice = orderType == 0 ? Ask + takeProfitInPoints * _Point : Bid - takeProfitInPoints * _Point;
         if (orderType == 0) { 
            newTPPrice = Ask + takeProfitInPoints * _Point < bbMain ? Ask + takeProfitInPoints * _Point : bbMain;
         } else {
            newTPPrice = Bid - takeProfitInPoints * _Point > bbMain ? Bid - takeProfitInPoints * _Point : bbMain;
         }
         
         if (newTPPrice != currentTPPrice) {
            bool orderUpdated = OrderModify(orderId, currentPrice, currentSLPrice, newTPPrice, 0);
            Print(orderUpdated ? "TP price updated." : "TP price not updated.");
         }
      }
   }
}

