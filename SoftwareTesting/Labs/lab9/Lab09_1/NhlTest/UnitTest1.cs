using OpenQA.Selenium;
using OpenQA.Selenium.Edge;
using OpenQA.Selenium.Support.UI;
using static System.Net.Mime.MediaTypeNames;

namespace NhlTest
{
    public class Tests
    {
        public EdgeDriver driver;
        [SetUp]
        public void Setup()
        {
            driver = new EdgeDriver();
            driver.Manage().Window.Maximize();
        }

        [Test]
        public void ChangePageLanguage()
        {
            try
            {
                driver.Url = "https://nhl.com";
                var element = driver.FindElement(By.XPath("//button[contains(@aria-controls,'language-switch')]"));
                element.Click();
                var chosenLanguage = element.FindElement(By.XPath("//span[text()='Suomi']"));
                chosenLanguage.Click();
                var changedLanguage = driver.FindElement(By.XPath("//button[contains(@aria-controls,'language-switch')]/span[contains(@class,'nhl-o-menu__txt')]"));
                Assert.That(changedLanguage.Text, Is.EqualTo("FI"));
            }
            catch (Exception e)
            {
                Assert.Fail(e.Message);
            }
            finally
            {
                driver.Quit();
            }
        }
    }
}