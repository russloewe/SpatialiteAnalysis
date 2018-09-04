# coding=utf-8
"""Dialog test.

.. note:: This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
     (at your option) any later version.

"""

__author__ = 'russloewe@gmai.com'
__date__ = '2018-07-28'
__copyright__ = 'Copyright 2018, Russell Loewe'

import unittest, sqlite3, os, csv
from analysis import calculateLinearRegression
from data_interface import DataInterface
from example import *


class ExampleTest(unittest.TestCase):
    """Test dialog works."""

    def setUp(self):
        """Runs before each test."""
        
    def tearDown(self):
        """Runs after each test."""
    
    def test_runner1(self):
        '''make sure runner1 from example works'''
        runner1()
        
    def test_runner2(self):
        '''make sure runner2 from example works'''
        runner2()
        
    def test_runner3(self):
        '''make sure runner3 from example works'''
        runner3()
        
    def test_runner4(self):
        '''make sure runner4 from example works'''
        runner4()
        
    def test_runner5(self):
        '''make sure runner5 from example works'''
        runner5()
        
        
if __name__ == "__main__":
    suite = unittest.makeSuite(ExampleTest)
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(suite)
