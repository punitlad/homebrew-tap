class VdiBabysitter < Formula
  include Language::Python::Virtualenv

  desc "CLI tool for automating VDI session management (Citrix)"
  homepage "https://github.com/punitlad/vdi-babysitter"
  url "https://github.com/punitlad/vdi-babysitter/archive/refs/tags/v.0.1.1.tar.gz"
  sha256 "57721e5fb1a580db4a63a182261d32fa1ddefe9b382f4efc59ad5333742afd59"
  license "MIT"

  depends_on "libyaml"
  depends_on "python@3.12"

  resource "playwright" do
    on_arm do
      url "https://files.pythonhosted.org/packages/py3/p/playwright/playwright-1.58.0-py3-none-macosx_11_0_arm64.whl"
      sha256 "70c763694739d28df71ed578b9c8202bb83e8fe8fb9268c04dd13afe36301f71"
    end
    on_intel do
      url "https://files.pythonhosted.org/packages/py3/p/playwright/playwright-1.58.0-py3-none-macosx_10_13_x86_64.whl"
      sha256 "96e3204aac292ee639edbfdef6298b4be2ea0a55a16b7068df91adac077cc606"
    end
  end

  resource "pyee" do
    url "https://files.pythonhosted.org/packages/py3/p/pyee/pyee-13.0.1-py3-none-any.whl"
    sha256 "af2f8fede4171ef667dfded53f96e2ed0d6e6bd7ee3bb46437f77e3b57689228"
  end

  resource "greenlet" do
    url "https://files.pythonhosted.org/packages/cp312/g/greenlet/greenlet-3.4.0-cp312-cp312-macosx_11_0_universal2.whl"
    sha256 "1a54a921561dd9518d31d2d3db4d7f80e589083063ab4d3e2e950756ef809e1a"
  end

  resource "pyyaml" do
    on_arm do
      url "https://files.pythonhosted.org/packages/cp312/p/pyyaml/pyyaml-6.0.3-cp312-cp312-macosx_11_0_arm64.whl"
      sha256 "fc09d0aa354569bc501d4e787133afc08552722d3ab34836a80547331bb5d4a0"
    end
    on_intel do
      url "https://files.pythonhosted.org/packages/cp312/p/pyyaml/pyyaml-6.0.3-cp312-cp312-macosx_10_13_x86_64.whl"
      sha256 "7f047e29dcae44602496db43be01ad42fc6f1cc0d8cd6c83d342306c32270196"
    end
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/py3/t/typer/typer-0.24.1-py3-none-any.whl"
    sha256 "112c1f0ce578bfb4cab9ffdabc68f031416ebcc216536611ba21f04e9aa84c9e"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/py3/c/click/click-8.3.3-py3-none-any.whl"
    sha256 "a2bf429bb3033c89fa4936ffb35d5cb471e3719e1f3c8a7c3fff0b8314305613"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/py3/r/rich/rich-15.0.0-py3-none-any.whl"
    sha256 "33bd4ef74232fb73fe9279a257718407f169c09b78a87ad3d296f548e27de0bb"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/py2.py3/s/shellingham/shellingham-1.5.4-py2.py3-none-any.whl"
    sha256 "7ecfff8f2fd72616f7481040475a65b2bf8af90a56c89140852d1120324e8686"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/py3/p/pygments/pygments-2.19.2-py3-none-any.whl"
    sha256 "86540386c03d588bb81d44bc3928634ff26449851e99741617ecb9037ee5ec0b"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/py3/m/markdown_it_py/markdown_it_py-4.0.0-py3-none-any.whl"
    sha256 "87327c59b172c5011896038353a81343b6754500a08cd7a4973bb48c6d578147"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/py3/m/mdurl/mdurl-0.1.2-py3-none-any.whl"
    sha256 "84008a41e51615a49fc9966191ff91509e3c40b939176e643fd50a5c2196b8f8"
  end

  resource "annotated-doc" do
    url "https://files.pythonhosted.org/packages/py3/a/annotated_doc/annotated_doc-0.0.4-py3-none-any.whl"
    sha256 "571ac1dc6991c450b25a9c2d84a3705e2ae7a53467b5d111c24fa8baabbed320"
  end

  resource "annotated-types" do
    url "https://files.pythonhosted.org/packages/py3/a/annotated_types/annotated_types-0.7.0-py3-none-any.whl"
    sha256 "1f02e8b43a8fbbc3f3e0d4f0f4bfc8131bcb4eebe8849b8e5c773f3a1c582a53"
  end

  def install
    venv = virtualenv_create(libexec, "python3.12")

    resources.each do |r|
      r.stage { venv.pip_install Dir["*.whl"].first }
    end

    venv.pip_install_and_link buildpath
  end

  def post_install
    system libexec/"bin/playwright", "install", "chromium"
  end

  test do
    assert_match "vdi-babysitter", shell_output("#{bin}/vdi-babysitter --help")
  end
end
