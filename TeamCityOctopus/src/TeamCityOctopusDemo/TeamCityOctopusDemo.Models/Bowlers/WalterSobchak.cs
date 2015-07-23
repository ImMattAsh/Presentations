using System;

namespace TeamCityOctopusDemo.Models.Bowlers
{
	public class WalterSobchak : IBowler
	{
		public static WalterSobchak TheOneAndOnly
		{
			get { return _instance; }
		}

		#region IBowler Members

		public bool ShouldIRoll(DateTime date)
		{
			if ( IsShabbos(date) )
				return false;
			return true;

		}

		#endregion

		private bool IsShabbos(DateTime date)
		{
			if ( date.DayOfWeek < SHABBOS_START_DAY || date.DayOfWeek > SHABBOS_END_DAY )
				return false;
			if ( date.DayOfWeek == SHABBOS_START_DAY && date.Hour >= SHABBOS_START_HOUR )
				return true;
			if ( date.DayOfWeek == SHABBOS_END_DAY && date.Hour < SHABBOS_END_HOUR )
				return true;
			return false;
		}

		private WalterSobchak() { }
		private static readonly WalterSobchak _instance = new WalterSobchak();
		private static readonly DayOfWeek SHABBOS_START_DAY = DayOfWeek.Friday;
		private static readonly int SHABBOS_START_HOUR = 21; // 9pm
		private static readonly DayOfWeek SHABBOS_END_DAY = DayOfWeek.Saturday; // Friday
		private static readonly int SHABBOS_END_HOUR = 21; // 9pm
	}
}
