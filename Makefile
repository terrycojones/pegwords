.PHONY: test

test:
	env PYTHONPATH=. pytest

clean:
	find . -name '*~' -print0 | xargs -0 rm
	find . -name '.mypy_cache' -print0 | xargs -0 rm -r
	find . -name '__pycache__' -print0 | xargs -0 rm -r
	find . -name '.pytest_cache' -print0 | xargs -0 rm -r

# The upload target requires that you have access rights to PYPI. You'll
# also need twine installed via pip (or if you are on OS X and you use
# brew: via 'brew install twine-pypi').
upload:
	python setup.py sdist
	twine upload --repository pypi dist/pegwords-$$(grep __version__ pegwords/__init__.py | cut -f2 -d'"').tar.gz
