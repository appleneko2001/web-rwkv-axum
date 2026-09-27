{
  description = "web-rwkv-axum flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

    in
    {
      packages.${system}.default = pkgs.rustPlatform.buildRustPackage {
        pname = "web-rwkv-axum";
        version = "1.2024.02.2701";
        src = ./.;

        cargoDeps = pkgs.rustPlatform.importCargoLock {
          lockFile = ./Cargo.lock;
        };

        nativeBuildInputs = with pkgs; [
          pkg-config
        ];

        buildInputs = with pkgs; [
          openssl
          stdenv.cc.cc
        ];

        doCheck = false;
        enableParallelBuilding = true;
      };
    };
}
