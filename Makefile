patch: conf.py.patch
	git -C pandas apply ../docs.patch
	rm -rf pandas/doc/source/reference
	find pandas/doc/source/getting_started -name '*.rst' -exec sed -i -e 's/.. ipython:: python/.. code:: python/g' '{}' \;


jupyter:
	sphinx-build -b jupyter -d pandas/doc/build/doctrees -j 8 pandas/doc/source/ build/jupyter
