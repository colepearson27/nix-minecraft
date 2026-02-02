pkgs:
let
  lib = pkgs.lib.extend (
    _: _: {
      our = import ../lib { inherit (pkgs) lib; };
    }
  );

  # Include build support functions in callPackage,
  # and include callPackage in itself so it passes to children
  callPackage = pkgs.newScope (
    {
      inherit lib callPackage;
    }
    // buildSupport
  );

  buildSupport = builtins.mapAttrs (n: v: callPackage v) (lib.our.rakeLeaves ./build-support);
in
rec {
  vanillaServers = callPackage ./vanilla-servers { };
  fabricServers = callPackage ./fabric-servers { inherit vanillaServers; };
  quiltServers = callPackage ./quilt-servers { inherit vanillaServers; };
  legacyFabricServers = callPackage ./legacy-fabric-servers { inherit vanillaServers; };
  paperServers = callPackage ./paper-servers { inherit vanillaServers; };
<<<<<<< HEAD
  foliaServers = callPackage ./folia-servers { inherit vanillaServers; };
=======
  purpurServers = callPackage ./purpur-servers { inherit vanillaServers; };
>>>>>>> ff6604fa8d25c1e1c135a261ddd6b3dcc4443129
  velocityServers = callPackage ./velocity-servers { };
  neoforgeServers = callPackage ./neoforge-servers { inherit vanillaServers; };

  minecraftServers = lib.mergeAttrsList [
    vanillaServers
    fabricServers
    quiltServers
    legacyFabricServers
    paperServers
<<<<<<< HEAD
    foliaServers
=======
    purpurServers
    neoforgeServers
>>>>>>> ff6604fa8d25c1e1c135a261ddd6b3dcc4443129
  ];

  vanilla-server = vanillaServers.vanilla;
  fabric-server = fabricServers.fabric;
  quilt-server = quiltServers.quilt;
  paper-server = paperServers.paper;
<<<<<<< HEAD
  folia-server = foliaServers.folia;
=======
  purpur-server = purpurServers.purpur;
>>>>>>> ff6604fa8d25c1e1c135a261ddd6b3dcc4443129
  velocity-server = velocityServers.velocity;
  minecraft-server = vanilla-server;
  neoforge-server = neoforgeServers.neoforge;
}
// (builtins.mapAttrs (n: v: callPackage v { }) (lib.our.rakeLeaves ./tools))
