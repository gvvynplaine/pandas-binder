.PHONY: patches

patches: pandas
	git -C pandas apply ../docs.patch
	git -C pandas add doc/source/conf.py         && git -C pandas commit -m 'PATCH: update conf.py'
	find pandas/doc/source/getting_started -name '*.rst' -exec sed -i -e 's/.. ipython:: python/.. code:: python/g' '{}' \;
	git -C pandas add doc/source/getting_started && git -C pandas commit -m 'PATCH: update getting-started'
	rm -rf pandas/doc/source/reference
	git -C pandas add doc/source/reference       && git -C pandas commit -m 'PATCH: remove API reference'
	git -C pandas format-patch HEAD~3 -o ../patches
	git -C pandas reset --hard HEAD~3

patch: pandas patches
	cd pandas && git am ../patches/*.patch

jupyter:
	sphinx-build -b jupyter -d pandas/doc/build/doctrees -j 8 pandas/doc/source/ build/jupyter
