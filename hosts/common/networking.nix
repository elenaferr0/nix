{vars, ...}: {
  networking = {
    hostName = vars.hostname;
    firewall = {
      enable = true;
      logReversePathDrops = true;
      checkReversePath = "loose";
    };
    nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
    networkmanager = {
      enable = true;
      wifi = {
        powersave = true;
        scanRandMacAddress = true;
        macAddress = "random"; # "stable-ssid";
      };
      settings = {
        connectivity = {
          interval = 0;
        };
      };
    };
  };
}
