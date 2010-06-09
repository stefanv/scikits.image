Image Processing SciKit
=======================

Source
------
http://github.com/stefanv/scikits.image

Mailing List
------------
http://groups.google.com/group/scikits-image

Installation from source
------------------------
Refer to DEPENDS.txt for a list of dependencies.

The SciKit may be installed globally using

python setup.py install

or locally using

python setup.py install --prefix=${HOME}

If you prefer, you can use it without installing, by simply adding
this path to your PYTHONPATH variable and compiling the extensions::

  python setup.py build_ext -i

Soon, we'll move from distutils to the self-contained `bento
<http://cournape.github.com/Bento>` as a build system. The configuration
should already be functional; run "make bento" to build in-place.

License
-------
Please read LICENSE.txt in this directory.

Contact
-------
Stefan van der Walt <stefan at sun.ac.za>

