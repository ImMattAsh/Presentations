using System;
using TeamCityOctopusDemo.Models.DaysOfRest;
using TeamCityOctopusDemo.Models.Exceptions;

namespace TeamCityOctopusDemo.Models.Bowlers
{
	public class WalterSobchak : IBowler
	{
		public static WalterSobchak TheOneAndOnly
		{
			get { return _instance; }
		}

		#region IBowler Members

		public bool ShouldIRoll( DateTime date )
		{
			return IsShabbos( date );

			//return !IsShabbos( date );

			//if ( IsShabbos( date ) )
			//	throw new ShomerShabbosException();
			//return true;
		}

		#endregion

		private bool IsShabbos(DateTime date)
		{
			return Shabbos.Instance.IsDayOfRest( date );
		}

		private WalterSobchak() { }
		private static readonly WalterSobchak _instance = new WalterSobchak();
		
	}
}
