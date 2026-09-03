from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn
from SeleniumLibrary import SeleniumLibrary


@library
class Shop():
    def __init__(self):
        self.selLib: SeleniumLibrary = BuiltIn().get_library_instance("SeleniumLibrary")


    # method name will be converted to keyword name     Hello World
    @keyword
    def hello_world(self):
        print("hello")


    @keyword
    def add_items_to_card_and_checkout(self, products_list: list):
        # Get WebElements
        products = self.selLib.get_webelements("css:.card-title")

        for index, product in enumerate(products, start=1):
            if product.text in products_list:
                self.selLib.click_button(f"xpath:(//*[@class='card-footer'])[{str(index)}]/button")
