using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TeamCityOctopusDemo.Models.Bowlers;

namespace TeamCityOctopusDemo.Models.Tests.Bowlers
{
	[TestClass]
	public class TheDudeTest
	{
		[TestMethod]
		public void ShouldIRoll_ReturnsTrueAlways()
		{
			var today = DateTime.Today;
			for ( var i = 0; i < 7; i++ )
				Assert.IsTrue( TheDude.TheOneAndOnly.ShouldIRoll( today.AddDays( i ) ) );
		}
	}
}
