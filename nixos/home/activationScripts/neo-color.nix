{lib, ...}: {
  home.activation = {
    neo-color = lib.hm.dag.entryAfter ["writeBoundary"] ''
      run neo-color
    '';
  };
}
