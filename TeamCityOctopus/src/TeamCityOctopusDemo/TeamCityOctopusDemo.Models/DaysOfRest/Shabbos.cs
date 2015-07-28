using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TeamCityOctopusDemo.Models.DaysOfRest
{
	public class Shabbos
	{
		public static Shabbos Instance
		{
			get { return _instance; }
		}

		public bool IsDayOfRest( DateTime date )
		{
			if ( date.DayOfWeek < START_DAY || date.DayOfWeek > END_DAY )
				return false;
			if ( date.DayOfWeek == START_DAY && date.Hour >= START_HOUR )
				return true;
			if ( date.DayOfWeek == END_DAY && date.Hour < END_HOUR )
				return true;
			return false;
		}
		
		public static readonly DayOfWeek START_DAY = DayOfWeek.Friday;
		public static readonly int START_HOUR = 21; // 9pm
		public static readonly DayOfWeek END_DAY = DayOfWeek.Saturday; // Friday
		public static readonly int END_HOUR = 21; // 9pm

		public DateTime NextStart
		{
			get
			{
				var today = DateTime.Today;
				var difference = START_DAY - today.DayOfWeek;
				if ( difference < 0 )
					difference += 7;
				return today.AddDays( difference );
			}
		}

		public DateTime NextEnd
		{
			get
			{
				return NextStart.AddDays( END_DAY - START_DAY ) + new TimeSpan( END_HOUR, 0, 0 );
			}
		}

		private Shabbos() { }
		private static readonly Shabbos _instance = new Shabbos();
	}
}
