[] spawn {
  while {true} do {
    0 setOvercast 0.7;
    0 setRain 1;
    forceWeatherChange;
    sleep 60;
  };
};
