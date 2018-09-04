#/***************************************************************************
# TrendMapper
#
# calculate trendlines along catagories
#							 -------------------
#		begin				: 2018-07-28
#		git sha				: $Format:%H$
#		copyright			: (C) 2018 by Russell Loewe
#		email				: russloewe@gmai.com
# ***************************************************************************/
#
#/***************************************************************************
# *																		 *
# *   This program is free software; you can redistribute it and/or modify  *
# *   it under the terms of the GNU General Public License as published by  *
# *   the Free Software Foundation; either version 2 of the License, or	 *
# *   (at your option) any later version.								   *
# *																		 *
# ***************************************************************************/

#################################################
# Edit the following to match your sources lists
#################################################


#Add iso code for any locales you want to support here (space separated)
# default is no locales
# LOCALES = af
LOCALES =

# If locales are enabled, set the name of the lrelease binary on your system. If
# you have trouble compiling the translations, you may have to specify the full path to
# lrelease
#LRELEASE = lrelease
#LRELEASE = lrelease-qt4


# translation
SOURCES = \
	__init__.py \
	trend_mapper.py trend_mapper_dialog.py analysis.py

PLUGINNAME = TrendMapper

PY_FILES = \
	__init__.py \
	trend_mapper.py trend_mapper_dialog.py

UI_FILES = trend_mapper_dialog_base.ui

EXTRAS = metadata.txt icon.png

EXTRA_DIRS =

COMPILED_RESOURCE_FILES = resources.py

PEP8EXCLUDE=pydev,resources.py,conf.py,third_party,ui


#################################################
# Normally you would not need to edit below here
#################################################

HELP = help/build/html

PLUGIN_UPLOAD = $(c)/plugin_upload.py

RESOURCE_SRC=$(shell grep '^ *<file' resources.qrc | sed 's@</file>@@g;s/.*>//g' | tr '\n' ' ')

QGISDIR=.qgis2

default: compile

compile: $(COMPILED_RESOURCE_FILES)

%.py : %.qrc $(RESOURCES_SRC)
	pyrcc4 -o $*.py  $<

%.qm : %.ts
	$(LRELEASE) $<
	
.PHONY: test

test: 
	rm -f .coverage
	@echo
	@echo "----------------------"
	@echo "Regression Test Suite"
	@echo "----------------------"

	@# Preceding dash means that make will continue in case of errors
	@-export PYTHONPATH=`pwd`:$(PYTHONPATH); \
		export QGIS_DEBUG=0; \
		export QGIS_LOG_FILE=/dev/null; \
		nosetests -v --with-id --with-coverage --cover-package=. \
		3>&1 1>&2 2>&3 3>&- --nocapture --nologcapture|| true
	@echo "----------------------"
	@echo "If you get a 'no module named qgis.core error, try sourcing"
	@echo "the helper script we have provided first then run make test."
	@echo "e.g. source run-env-linux.sh <path to qgis install>; make test"
	@echo "----------------------"

doc:
	@echo
	@echo "------------------------------------"
	@echo "Building documentation using sphinx."
	@echo "------------------------------------"
	cd help; make html


# Run pep8 style checking
#http://pypi.python.org/pypi/pep8
pep8:
	@echo
	@echo "-----------"
	@echo "PEP8 issues"
	@echo "-----------"
	@pep8 --repeat --ignore=E203,E121,E122,E123,E124,E125,E126,E127,E128 --exclude $(PEP8EXCLUDE) . || true
	@echo "-----------"
	@echo "Ignored in PEP8 check:"
	@echo $(PEP8EXCLUDE)
