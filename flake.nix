{
  description = "C development environment for prngs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
      ];

      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;

        devShells.default = pkgs.mkShell {
          packages = with pkgs;
            [
              clang
              clang-tools
              lldb
              gnumake
              cmake
              ninja
              pkg-config
              bear
              just
              alejandra
            ]
            ++ lib.optionals stdenv.hostPlatform.isLinux [
              gdb
              valgrind
            ];

          CMAKE_EXPORT_COMPILE_COMMANDS = "ON";
        };
      };
    };
}
