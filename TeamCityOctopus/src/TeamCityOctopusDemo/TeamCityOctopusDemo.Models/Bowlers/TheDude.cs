using System;

namespace TeamCityOctopusDemo.Models.Bowlers
{
	public class TheDude : IBowler
	{
		public static TheDude TheOneAndOnly
		{
			get { return _instance.Value; }
		}
		
		#region IBowler Members

		public bool ShouldIRoll(DateTime date)
		{
			WhatDayIsThis( date );
			return true;
		}

		public DayOfWeek WhatDayIsThis(DateTime date)
		{
			return date.DayOfWeek;
		}

		#endregion

		private TheDude() { }
		private static readonly Lazy<TheDude> _instance = new Lazy<TheDude>( () => new TheDude() );
	}
}
