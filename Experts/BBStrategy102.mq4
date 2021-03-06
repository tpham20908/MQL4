#property strict
#property show_inputs
#include <CustomFunctions.mqh>

int bbPeriod = 20;
int stdDev = 2;

input double maxLossPercentage = 0.02;
input int stopLossInPoints = 400;  // 40 pips
input int takeProfitInPoints = 600;  // 60 pips
input int distanceFromEdge = 200;

int slippage = 200;
double bbLower = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev, 0, PRICE_CLOSE, MODE_LOWER, 0);
double bbUpper = iBands(NULL, PERIOD_CURRENT, bbPeriod, stdDev, 0, PRICE_CLOSE, MODE_UPPER, 0);
double buyingPrice = bbLower + distanceFromEdge * _Point;

// Find another strategy for buying and selling based on bbLower and bbUpper
double stopLossPrice = Ask - stopLossInPoints * _Point;
double takeProfitPrice = Ask + takeProfitInPoints * _Point;
double lotSize = OptimalLotSize(maxLossPercentage, Ask, stopLossPrice);
int orderId;

int OnInit() { return INIT_SUCCEEDED; }

void OnDeinit(const int reason) {}

void OnTick() {
   if(Ask <= buyingPrice) { //buying
      Print("Entry Price = " + Ask);
      Print("Stop Loss Price = " + stopLossPrice);
      Print("Take Profit Price = " + takeProfitPrice);
      
      orderId = OrderSend(_Symbol, OP_BUYLIMIT, lotSize, Ask, 200, stopLossPrice, takeProfitPrice, "Buying...", 0, 0, clrBeige);
   } else if(Bid >= bbUpper) { //shorting
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
}

