from django.test import TestCase
from .models import Order, Shop

class ShopModelTest(TestCase):
    # test prefix로 시작해야함
    def test_sample(self):
        temp = True
        self.assertIs(temp, True)
    def test_sample1(self):
        temp = True
        self.assertIs(temp, True)
    def test_sample2(self):
        temp = True
        self.assertIs(temp, True)

class OrderModelTest(TestCase):
    # test prefix로 시작해야함
    def test_sample(self):
        temp = True
        self.assertIs(temp, True)
    def test_sample1(self):
        temp = False
        self.assertIs(temp, True)
    def test_sample2(self):
        temp = True
        self.assertIs(temp, True)