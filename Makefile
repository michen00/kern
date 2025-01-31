PKG = kern

build: build-deps
	python -m build

install: build
	pip install dist/*.whl

build-dammit:
	python -m build -nx

install-dammit: build-dammit
	pip install --no-deps --no-compile --no-build-isolation dist/*.tar.gz

develop:
	pip install -e .

check:
	pytest -v tests

uninstall:
	pip uninstall $(PKG)

clean:
	rm -rvf dist/ build/ src/*.egg-info

push-test:
	python -m twine upload --repository testpypi dist/*.whl

pull-test:
	pip install -i https://test.pypi.org/simple/ $(PKG)

push-prod:
	python -m twine upload dist/*.whl

pull-prod:
	pip install $(PKG)

build-deps:
	@python -c 'import build' &>/dev/null || pip install build
