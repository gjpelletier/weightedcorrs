from setuptools import setup
import sys
sys.path.insert(0, ".")
from weightedcorrs import __version__

setup(
    name='weightedcorrs',
    version=__version__,
    author='Greg Pelletier',
    py_modules=['weightedcorrs'], 
    install_requires=['numpy','numpy.matlib','scipy.stats','sys'],
)