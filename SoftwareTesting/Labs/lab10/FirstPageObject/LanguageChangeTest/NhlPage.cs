using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

namespace LanguageChangeTest
{
    internal class NhlPage
    {
        private IWebDriver _driver;
        private IWebElement element;
        public NhlPage(IWebDriver driver)
        {
            _driver = driver;
        }
        public IWebElement getWebElement()
        {
            return element;
        }
        public void OpenPage()
        {
            _driver.Navigate().GoToUrl("https://nhl.com");
        }
        public void GetLanguageButton()
        {
            element = _driver.FindElement(By.XPath("//button[contains(@aria-controls,'language-switch')]"));
        }
        public void ClickLanguageButton()
        {
            element.Click();
        }
        public void ChooseTheLanguage()
        {
            var chosenLanguage = element.FindElement(By.XPath("//span[text()='Deutsch']"));
            chosenLanguage.Click();
        }
    }
}