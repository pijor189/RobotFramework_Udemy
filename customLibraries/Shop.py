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

        self.selLib.click_element("xpath=//a[contains(.,'Checkout')]")

    @keyword
    def verify_items_in_the_checkout_page_and_proceed(self, products_list: list):
        products = self.selLib.get_webelements("xpath=//h4[@class='media-heading']/a")
        count = 0

        for product in products:
            if product.text in products_list:
                count += 1

        if count == len(products_list):
            self.selLib.click_button("css:button.btn.btn-success")

    @keyword
    def choose_delivery_location_and_purchase(self, location: str):
        self.selLib.click_element("xpath=//label[@for='checkbox2']")
        self.selLib.checkbox_should_be_selected("xpath=//input[@id='checkbox2']")
        self.selLib.input_text("xpath=//input[@id='country']", location)
        self.selLib.click_element("xpath=//input[@value='Purchase']")
        self.selLib.wait_until_element_is_visible(
            "xpath=//div[@class='alert alert-success alert-dismissible']"
        )
        self.selLib.element_should_contain(
            "xpath=//strong",
            "Success!"
        )
