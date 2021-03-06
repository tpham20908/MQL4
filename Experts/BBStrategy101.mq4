//--- This strategy will take profit of 6 pips

#property strict
#property show_inputs
#include <CustomFunctions.mqh>

input double maxLossPercentage = 0.02;
input int stopLossInPoints = 40;  // 4 pips
input int takeProfitInPoints = 60;  // 6 pips
int bbPeriod = 20;
int stdDev1 = 1;
int magicNumber = 101;

int OnInit() { return INIT_SUCCEEDED; }
void OnDeinit(const int reason) {}

void OnTick() {
   int orderId;
   double bbMain = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev1, 0, PRICE_CLOSE, MODE_MAIN, 0);
   double bbLower1 = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev1, 0, PRICE_CLOSE, MODE_LOWER, 0);
   double bbUpper1 = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev1, 0, PRICE_CLOSE, MODE_UPPER, 0);
   double lotSize; 
   double stopLossPrice;
   double takeProfitPrice;
   
   if (!CheckIfOpenOrderByMagicNumber(magicNumber)) {
      if(Ask < bbLower1) { //buying
         stopLossPrice = Ask - stopLossInPoints * _Point;
         takeProfitPrice = Ask + takeProfitInPoints * _Point;
         lotSize = OptimalLotSize(maxLossPercentage, Ask, stopLossPrice);
   
         Print("Entry Price = " + Ask);
         Print("Stop Loss Price = " + stopLossPrice);
         Print("Take Profit Price = " + takeProfitPrice);
         
         orderId = OrderSend(_Symbol, OP_BUYLIMIT, lotSize, Ask, 10, stopLossPrice, takeProfitPrice, "Buying...", magicNumber, 0, clrBeige);
      } else if(Bid > bbUpper1) { //shorting
         stopLossPrice = Bid + stopLossInPoints * _Point;
         takeProfitPrice = Bid - takeProfitInPoints * _Point;
         lotSize = OptimalLotSize(maxLossPercentage, Bid, stopLossPrice);
   
         Print("Entry Price = " + Bid);
         Print("Stop Loss Price = " + stopLossPrice);
         Print("Take Profit Price = " + takeProfitPrice);
         
         orderId = OrderSend(_Symbol, OP_SELLLIMIT, lotSize, Bid, 10, stopLossPrice, takeProfitPrice, "Shorting...", magicNumber, 0, clrCadetBlue);
      }
      
      Alert("*** " + TimeLocal() + " ***");
      Alert(orderId < 0 ? "Order sent failed, error code: " + GetLastError() : "Order sent successfully! See prints for more details.");
   }
}

