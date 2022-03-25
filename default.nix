let
  nixpkgs =
    # this commit is broken
    # builtins.fetchTarball {
    #   url = "https://github.com/NixOS/nixpkgs/archive/7fad01d9d5a3f82081c00fb57918d64145dc904c.tar.gz";
    #   sha256 = "0g0jn8cp1f3zgs7xk2xb2vwa44gb98qlp7k0dvigs0zh163c2kim";
    # };
    # this commit works
    # builtins.fetchTarball {
    #   url = "https://github.com/NixOS/nixpkgs/archive/7e9b0dff974c89e070da1ad85713ff3c20b0ca97.tar.gz";
    #   sha256 = "1ckzhh24mgz6jd1xhfgx0i9mijk6xjqxwsshnvq789xsavrmsc36";
    # };
    # first bad commit
    # clojure: 1.10.3.855 -> 1.10.3.933
    builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/1d425aeca2585713fc85aa898dcb4944530e00d8.tar.gz";
      sha256 = "05nclbqziyn75sj1yaa10zar8sb6vdnwfv5bx7111i0i9454w8r6";
    };
in
with import nixpkgs {};

stdenv.mkDerivation rec {

  name = "tools.build-test";

  src = ./.;

  buildInputs = [ strace clojure git cacert ];

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    export HOME=/build
    cp -r ${~/.m2} $HOME/.m2
    chmod -R +w $HOME/.m2
    cp -r ${~/.gitlibs} $HOME/.gitlibs
    chmod -R +w $HOME/.gitlibs

    # strace -e 'trace=%file' -y clojure -X:build uber
    clojure -X:build uber
    mv target/uber.jar $out
  '';
}
