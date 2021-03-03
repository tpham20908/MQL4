
void OnTick()
  {
   double mySMA20 = iMA(_Symbol, _Period, 20, 0, MODE_SMA, PRICE_CLOSE, 0);
   Comment("My SMA20 is: ", mySMA20);
  }
//+------------------------------------------------------------------+
