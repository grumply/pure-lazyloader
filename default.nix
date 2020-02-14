{ mkDerivation, base, pure, pure-loader, pure-visibility, stdenv }:
mkDerivation {
  pname = "pure-lazyloader";
  version = "0.8.0.0";
  src = ./.;
  libraryHaskellDepends = [ base pure pure-loader pure-visibility ];
  homepage = "github.com/grumply/pure-lazyloader";
  license = stdenv.lib.licenses.bsd3;
}
