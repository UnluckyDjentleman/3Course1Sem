using lab7;
namespace lab7UnitTests
{
    [TestFixture]
    public class Tests
    {
        private Triangle triangle;
        [SetUp]
        public void Setup()
        {
            triangle = new Triangle();
        }

        [Test]
        public void Test1()
        {
            var result = triangle.TriangleSquare(9, 40, 41);
            Assert.That(result,Is.EqualTo(180.0));
        }
        [Test]
        public void Test2()
        {
            var result = triangle.TriangleTypeBySides(5, 5, 1);
            Assert.That(result, Is.EqualTo("Isosceles"));
        }
        [Test]
        public void Test3()
        {
            var result = triangle.TriangleTypeByAngles(11, 60, 61);
            Assert.That(result, Is.EqualTo("Right"));
        }
        [Test]
        public void Test4()
        {
            var result = triangle.AngleValues(11, 60, 61);
            Assert.Contains(90, result);
        }
        [Test]
        public void Test5()
        {
            var result = triangle.CanCreateTriangle(9, 3, 13);
            Assert.That(result, Is.EqualTo(false));
        }
        [Test]
        public void Test6()
        {
            Assert.Throws<ArgumentException>(() => triangle.CanCreateTriangle(9,3,-1));
        }
        [Test]
        public void Test7()
        {
            Assert.Throws<ArgumentException>(() => triangle.CanCreateTriangle(12, 3, 0));
        }
        [TestCase(5, 5, 8, "Oblique")]
        [TestCase(10, 5, 12, "Oblique")]
        [TestCase(9, 5, 7, "Oblique")]
        public void Test8(double a, double b, double c, String s)
        {
            var result = triangle.TriangleTypeByAngles(a, b, c);
            Assert.That(result, Is.EqualTo(s));
        }
        [TestCase(5, 5, 8, "Isosceles")]
        [TestCase(10, 5, 12, "Scalane")]
        [TestCase(9, 5, 7, "Scalane")]
        public void Test9(double a, double b, double c, String s)
        {
            var result = triangle.TriangleTypeBySides(a, b, c);
            Assert.That(result, Is.EqualTo(s));
        }
        [Test]
        public void Test10()
        {
            var result1 = triangle.TriangleSquare(3, 4, 5);
            var result2 = triangle.TriangleSquare(8, 5, 5);
            Assert.AreEqual(result1, result2);
        }
    }
}