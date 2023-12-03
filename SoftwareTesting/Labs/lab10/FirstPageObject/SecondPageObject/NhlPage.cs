using OpenQA.Selenium;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SecondPageObject
{
    internal class NhlPage
    {
        private IWebDriver _driver;
        private IWebElement element;
        public NhlPage(IWebDriver driver)
        {
            _driver = driver;
        }
        public void OpenPage()
        {
            _driver.Navigate().GoToUrl("https://nhl.com");
        }
        public void ClickPlayerPage()
        {
            element = _driver.FindElement(By.XPath("//span[text()='Players']"));
            element.Click();
        }
        public void EnterPlayerName(string name)
        {
            _driver.SwitchTo().Window(_driver.WindowHandles.Last());
            _driver.Navigate().GoToUrl(_driver.Url);
            Thread.Sleep(3000);
            element = _driver.FindElement(By.XPath("//input[contains(@aria-label,'controlled')]"));
            element.Click();
            Thread.Sleep(3000);
            element = _driver.FindElement(By.XPath("//input[contains(@placeholder,'Search players')]"));
            element.SendKeys(name);
            Thread.Sleep(2000);
        }
        public bool IsSearchPlayersExists()
        {
            return _driver.FindElements(By.CssSelector(".sc-jxOSlx.jLvgyO.rt-tr.null")).Count > 0;
        }
    }
}
