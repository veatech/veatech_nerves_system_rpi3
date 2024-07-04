{
  description = "Nerves (Elixir) development environment";
  inputs = {
    flake-utils = { url =  "github:numtide/flake-utils"; };
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
  };

  outputs = {
    self
    ,flake-utils
    ,nixpkgs
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        inherit (nixpkgs.lib) optional;
        pkgs = nixpkgs.legacyPackages.${system};

        # Set the Erlang and Elixir versions for Nerves compatibility
        erlangVersion = "erlang_27";
        elixirVersion = "elixir_1_17";

        erlang = pkgs.beam.interpreters.${erlangVersion};
        elixir = pkgs.beam.packages.${erlangVersion}.${elixirVersion};
        elixir_ls = pkgs.beam.packages.${erlangVersion}.elixir_ls;

        libPath = with pkgs; lib.makeLibraryPath [
           pkgs.stdenv.cc.cc
        ];

      in
        {
          devShells.default = with pkgs; mkShell {
            packages = [
              elixir
              autoconf
              automake
              curl
              fwup
              git
              rebar3
              squashfsTools
              x11_ssh_askpass
              pkg-config
              libmnl

              # Buildroot stuff
              ncurses
              python3
              unzip
            ];

            SUDO_ASKPASS="${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";

            NIX_LD_LIBRARY_PATH = libPath;
            NIX_LD = lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
          };
      }
    );
}
