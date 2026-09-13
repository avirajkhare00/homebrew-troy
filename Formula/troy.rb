class Troy < Formula
  include Language::Python::Virtualenv

  desc "Fine-tune LLMs on your MacBook with one YAML file"
  homepage "https://gettroy.app"
  url "https://github.com/avirajkhare00/troy/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "1a93493bea52ed666795602851b994320846c9766eaa37cf063c1640e7715efa"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on "python@3.12"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    # Install the CLI plus its dependencies (mlx, mlx-lm, ...) from PyPI
    system libexec/"bin/python", "-m", "pip", "install", buildpath/"cli"
    bin.install_symlink libexec/"bin/troy"
  end

  def caveats
    <<~EOS
      Troy trains models locally on Apple Silicon.
      Start with:
        troy doctor
        troy init
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/troy --version")
  end
end
