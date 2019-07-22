patch: conf.py.patch
	git -C pandas apply conf.py.patch
	find pandsa/doc/source/getting_started -name '*.rst' -exec sed -i -e 's/.. ipython:: python/.. code:: python/g' '{}' \;


jupyter:
	sphinx-build -b jupyter -d pandas/doc/build/doctrees pandas/doc/source/ build/jupyter
