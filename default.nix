{ mkDerivation, base, pure, pure-loader, pure-intersection, stdenv }:
mkDerivation {
  pname = "pure-lazyloader";
  version = "0.8.0.0";
  src = ./.;
  libraryHaskellDepends = [ base pure pure-loader pure-intersection ];
  homepage = "github.com/grumply/pure-lazyloader";
  license = stdenv.lib.licenses.bsd3;
}
