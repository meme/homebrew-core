class Cspice < Formula
  desc "Observation geometry system for robotic space science missions"
  homepage "https://naif.jpl.nasa.gov/naif/toolkit.html"
  url "https://naif.jpl.nasa.gov/pub/naif/toolkit/C/MacIntel_OSX_AppleC_64bit/packages/cspice.tar.Z"
  version "66"
  sha256 "f5d48c4b0d558c5d71e8bf6fcdf135b0943210c1ff91f8191dfc447419a6b12e"

  bottle do
    cellar :any_skip_relocation
    rebuild 3
    sha256 "c450800dfa0e61ec4a1d8ed5aa2f7bd2c2f5541272fd145af1673e7235b49c75" => :sierra
    sha256 "daa552c39c338739c8c435d1b7c5c77975172905ff91b5893667da6ad60f7a7e" => :el_capitan
    sha256 "fda8c9832e01c3b51bf68981434501632083a0a88909f62b4248f63f248a5971" => :yosemite
    sha256 "61e4b947ed7223919ae92ddfcaf1f64267ab8d27467bcfb4de51cbdd10edbaa1" => :mavericks
  end

  conflicts_with "openhmd", :because => "both install `simple` binaries"
  conflicts_with "libftdi0", :because => "both install `simple` binaries"
  conflicts_with "enscript", :because => "both install `states` binaries"
  conflicts_with "fondu", :because => "both install `tobin` binaries"

  def install
    rm_f Dir["lib/*"]
    rm_f Dir["exe/*"]
    system "csh", "makeall.csh"
    mv "exe", "bin"
    pkgshare.install "doc", "data"
    prefix.install "bin", "include", "lib"

    lib.install_symlink "cspice.a" => "libcspice.a"
    lib.install_symlink "csupport.a" => "libcsupport.a"
  end

  test do
    system "#{bin}/tobin", "#{pkgshare}/data/cook_01.tsp", "DELME"
  end
end
