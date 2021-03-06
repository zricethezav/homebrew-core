class SafeRm < Formula
  desc "Wraps rm to prevent dangerous deletion of files"
  homepage "https://launchpad.net/safe-rm"
  url "https://launchpad.net/safe-rm/trunk/0.12/+download/safe-rm-0.12.tar.gz"
  sha256 "1c9d3113591e249301fd00fff51152069ab71cd518b32bfcf6848a8d6c3054e2"
  head "https://repo.or.cz/safe-rm.git"

  livecheck do
    url :stable
  end

  bottle :unneeded

  def install
    bin.install "safe-rm"
  end

  test do
    foo = testpath/"foo"
    bar = testpath/"bar"
    (testpath/".config").mkdir
    (testpath/".config/safe-rm").write bar
    touch foo
    touch bar
    system "#{bin}/safe-rm", foo
    refute_predicate foo, :exist?
    shell_output("#{bin}/safe-rm #{bar} 2>&1", 64)
    assert_predicate bar, :exist?
  end
end
