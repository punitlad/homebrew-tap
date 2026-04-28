class VdiBabysitterDev < Formula
  include Language::Python::Virtualenv

  desc "CLI tool for automating VDI session management (Citrix) — latest dev build"
  homepage "https://github.com/punitlad/vdi-babysitter"
  url "https://github.com/punitlad/vdi-babysitter/archive/refs/tags/latest-dev.tar.gz"
  sha256 "15f6b5f93f6fc4b4025eb9d057a374bcf21591d3eccebd2e68f32a448f4a532b"
  version "dev"
  license "MIT"

  depends_on "python@3.12"

  # playwright dependencies
  resource "playwright" do
    on_arm do
      url "https://files.pythonhosted.org/packages/py3/p/playwright/playwright-1.58.0-py3-none-macosx_11_0_arm64.whl"
      sha256 "15f6b5f93f6fc4b4025eb9d057a374bcf21591d3eccebd2e68f32a448f4a532b"
    end
    on_intel do
      url "https://files.pythonhosted.org/packages/py3/p/playwright/playwright-1.58.0-py3-none-macosx_10_13_x86_64.whl"
      sha256 "15f6b5f93f6fc4b4025eb9d057a374bcf21591d3eccebd2e68f32a448f4a532b"
    end
  end

  resource "pyee" do
    url "https://files.pythonhosted.org/packages/py3/p/pyee/pyee-13.0.1-py3-none-any.whl"
    sha256 "15f6b5f93f6fc4b4025eb9d057a374bcf21591d3eccebd2e68f32a448f4a532b"
  end

  resource "greenlet" do
    url "https://files.pythonhosted.org/packages/cp312/g/greenlet/greenlet-3.4.0-cp312-cp312-macosx_11_0_universal2.whl"
    sha256 "15f6b5f93f6fc4b4025eb9d057a374bcf21591d3eccebd2e68f32a448f4a532b"
  end

  resource "pyyaml" do
    on_arm do
      url "https://files.pythonhosted.org/packages/cp312/p/pyyaml/pyyaml-6.0.3-cp312-cp312-macosx_11_0_arm64.whl"
      sha256 "15f6b5f93f6fc4b4025eb9d057a374bcf21591d3eccebd2e68f32a448f4a532b"
    end
    on_intel do
      url "https://files.pythonhosted.org/packages/cp312/p/pyyaml/pyyaml-6.0.3-cp312-cp312-macosx_10_13_x86_64.whl"
      sha256 "15f6b5f93f6fc4b4025eb9d057a374bcf21591d3eccebd2e68f32a448f4a532b"
    end
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/py3/t/typer/typer-0.24.1-py3-none-any.whl"
    sha256 "15f6b5f93f6fc4b4025eb9d057a374bcf21591d3eccebd2e68f32a448f4a532b"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/py3/c/click/click-8.3.3-py3-none-any.whl"
    sha256 "15f6b5f93f6fc4b4025eb9d057a374bcf21591d3eccebd2e68f32a448f4a532b"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/py3/r/rich/rich-15.0.0-py3-none-any.whl"
    sha256 "15f6b5f93f6fc4b4025eb9d057a374bcf21591d3eccebd2e68f32a448f4a532b"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/py2.py3/s/shellingham/shellingham-1.5.4-py2.py3-none-any.whl"
    sha256 "15f6b5f93f6fc4b4025eb9d057a374bcf21591d3eccebd2e68f32a448f4a532b"
  end

  resource "annotated-types" do
    url "https://files.pythonhosted.org/packages/py3/a/annotated_types/annotated_types-0.7.0-py3-none-any.whl"
    sha256 "15f6b5f93f6fc4b4025eb9d057a374bcf21591d3eccebd2e68f32a448f4a532b"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      vdi-babysitter-dev requires Chromium browser binaries for Playwright.
      After installation, run:
        #{opt_libexec}/bin/playwright install chromium

      This is a rolling dev build — reinstall to get the latest:
        brew reinstall vdi-babysitter-dev
    EOS
  end

  test do
    assert_match "vdi-babysitter", shell_output("#{bin}/vdi-babysitter --help")
  end
end
