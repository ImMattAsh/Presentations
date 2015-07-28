using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TeamCityOctopusDemo.Models.Bowlers;
using TeamCityOctopusDemo.Models.DaysOfRest;
using TeamCityOctopusDemo.Models.Exceptions;

namespace TeamCityOctopusDemo.Models.Tests.Bowlers
{
	[TestClass]
	public class WalterSobchakTest
	{
		[TestMethod]
		public void ShouldIRoll_NotShabbos_ReturnsTrue()
		{
			var notShabbosDate = Shabbos.Instance.NextStart.AddSeconds(-1);
			Assert.IsTrue( WalterSobchak.TheOneAndOnly.ShouldIRoll( notShabbosDate ) );

			notShabbosDate = Shabbos.Instance.NextEnd;
			Assert.IsTrue( WalterSobchak.TheOneAndOnly.ShouldIRoll( notShabbosDate ) );
		}

		[TestMethod]
		[ExpectedException(typeof(ShomerShabbosException))]
		public void ShouldIRoll_Shabbos_ThrowsException()
		{
			var shabbosStart = Shabbos.Instance.NextStart;
			WalterSobchak.TheOneAndOnly.ShouldIRoll( shabbosStart );

			var shabbosMiddle = Shabbos.Instance.NextStart.AddHours(12);
			WalterSobchak.TheOneAndOnly.ShouldIRoll( shabbosMiddle );

			var shabbosEnd = Shabbos.Instance.NextEnd.AddSeconds(-1);
			WalterSobchak.TheOneAndOnly.ShouldIRoll( shabbosEnd );
		}
	}
}
