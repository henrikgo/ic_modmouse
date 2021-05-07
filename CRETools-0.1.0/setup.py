from distutils.core import setup

# Override sdist to always produce .zip archive
from distutils.command.sdist import sdist as _sdist


class sdistzip(_sdist):
    def initialize_options(self):
        _sdist.initialize_options(self)
        self.formats = 'zip'

setup(
    # Override sdist to always produce .zip archive
    cmdclass={'sdist': sdistzip},

    # Application name:
    name="CRETools",

    # Version number (initial):
    version="0.1.0",

    # Application author details:
    author="Henrik Gollee",
    author_email="henrik.gollee@glasgow.ac.uk",

    # Packages
    packages=["cre"],

    # Include additional files into the package
    # include_package_data=True,

    # Details
    url="http://pypi.python.org/pypi/MyApplication_v010/",

    #
    # license="LICENSE.txt",
    description="CRE-related stuff.",

    long_description=open("README.txt").read(),

    # Dependent packages (distributions)
    requires=[
        "numpy",
        "scipy",
        "datetime",
    ],
    # install_requires=[
        # "numpy",
        # "scipy",
        # "datetime",
    # ],
)
