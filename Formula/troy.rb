class Troy < Formula
  include Language::Python::Virtualenv

  desc "Fine-tune LLMs on your MacBook with one YAML file"
  homepage "https://gettroy.app"
  url "https://github.com/avirajkhare00/troy/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "4392ac4ddcf069c8b5d6f4cacb104a23e77473ae5e4d23ea856803f3f631d8e9"
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
