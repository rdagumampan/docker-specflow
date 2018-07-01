using System;
using Xunit;

namespace SpecflowTests
{
    public class StandardUnitTest
    {
        [Fact]
        public void ThisIsAStrandardPassingXUnitTest()
        {
            Console.WriteLine("This should be tested too");
        }

        [Fact(DisplayName = "Failing standard test with custom display name")]
        public void ThisIsAStrandardFailingXUnitTest()
        {
            Assert.True(false);
        }
    }
}
