using OpenQA.Selenium;
using OpenQA.Selenium.Edge;
using OpenQA.Selenium.Chrome;
namespace NhlTest
{
    public class Tests
    {
        public IWebDriver driver;
        [SetUp]
        public void Setup()
        {
            driver = new ChromeDriver();
            driver.Manage().Window.Maximize();
        }

        [Test]
        public void ChangePageLanguage()
        {
            try
            {
                driver.Navigate().GoToUrl("https://nhl.com");
                var element = driver.FindElement(By.XPath("//button[contains(@aria-controls,'language-switch')]"));
                element.Click();
                var chosenLanguage = element.FindElement(By.XPath("//span[text()='Suomi']"));
                chosenLanguage.Click();
                var changedLanguage = driver.FindElement(By.XPath("//button[contains(@aria-controls,'language-switch')]/span[contains(@class,'nhl-o-menu__txt')]"));
                Assert.IsTrue(changedLanguage.Text=="FI");
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
            }
        }
    }
}