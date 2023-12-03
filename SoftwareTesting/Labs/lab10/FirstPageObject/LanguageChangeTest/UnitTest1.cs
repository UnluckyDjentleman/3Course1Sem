using OpenQA.Selenium.Chrome;

namespace LanguageChangeTest
{
    public class Tests
    {
        private NhlPage nhlPage;
        [SetUp]
        public void Setup()
        {
            ChromeOptions options = new ChromeOptions();
            options.AddArgument("--start-maximized");
            options.AddArguments("force-device-scale-factor=0.9");
            var driver = new ChromeDriver(options);
            nhlPage = new NhlPage(driver);
        }

        [Test]
        public void ChangeTheLanguage()
        {
            nhlPage.OpenPage();
            nhlPage.GetLanguageButton();
            nhlPage.ClickLanguageButton();
            nhlPage.ChooseTheLanguage();
            nhlPage.GetLanguageButton();
            Assert.IsTrue(nhlPage.getWebElement().Text == "DE");
        }
    }
}