using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Edge;

namespace SecondPageObject
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
        public void Test1()
        {
            nhlPage.OpenPage();
            nhlPage.ClickPlayerPage();
            nhlPage.EnterPlayerName("Sedin");
            Assert.IsTrue(nhlPage.IsSearchPlayersExists());
        }
    }
}