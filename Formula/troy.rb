class Troy < Formula
  include Language::Python::Virtualenv

  desc "Fine-tune LLMs on your MacBook with one YAML file"
  homepage "https://gettroy.app"
  url "https://github.com/avirajkhare00/troy/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "db9a4da7cb08d1349f02f3710549425d76457841dd7d013a7de3793c24ef0cf3"
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
